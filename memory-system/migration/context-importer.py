#!/usr/bin/env python3
"""
CB-Workspace Context File Importer for OpenMemory

Imports existing .claude/branch-context/*.md files into OpenMemory
with proper tagging and metadata preservation.
"""

import os
import re
import json
import requests
import argparse
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Tuple

# Configuration
API_URL = "http://localhost:8080"
API_KEY = "fGqS8XZNFZnjzONJu5bOrBH+nCioPsnP3SZvWLbODXw="
USER_ID = "cb-workspace"

HEADERS = {
    "Content-Type": "application/json",
    "Authorization": f"Bearer {API_KEY}"
}

class ContextImporter:
    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update(HEADERS)
        self.imported_count = 0
        self.failed_count = 0

    def check_server(self) -> bool:
        """Check if OpenMemory server is running"""
        try:
            response = self.session.get(f"{API_URL}/health")
            return response.status_code == 200
        except requests.RequestException:
            return False

    def parse_context_file(self, file_path: Path) -> Dict:
        """Parse a context markdown file and extract structured data"""
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Extract metadata from header
        metadata = self.extract_metadata(content, file_path)

        # Parse sections
        sections = self.parse_sections(content)

        # Generate tags
        tags = self.generate_tags(file_path, metadata, sections)

        return {
            'content': content,
            'sections': sections,
            'metadata': metadata,
            'tags': tags
        }

    def extract_metadata(self, content: str, file_path: Path) -> Dict:
        """Extract metadata from file header"""
        metadata = {
            'source_file': str(file_path),
            'import_date': datetime.now().isoformat(),
        }

        # Extract saved date
        saved_match = re.search(r'\*\*Saved:\*\* (.+)', content)
        if saved_match:
            metadata['original_saved_date'] = saved_match.group(1)

        # Extract working directory
        dir_match = re.search(r'\*\*Last Working Directory:\*\* (.+)', content)
        if dir_match:
            metadata['working_directory'] = dir_match.group(1)

        # Extract project info
        project_match = re.search(r'\*\*Project:\*\* (.+)', content)
        if project_match:
            metadata['project_info'] = project_match.group(1)

        return metadata

    def parse_sections(self, content: str) -> Dict:
        """Parse markdown sections from content"""
        sections = {}

        # Split content into sections
        section_pattern = r'^## (.+)$'
        current_section = None
        current_content = []

        for line in content.split('\n'):
            match = re.match(section_pattern, line)
            if match:
                # Save previous section
                if current_section:
                    sections[current_section] = '\n'.join(current_content).strip()

                # Start new section
                current_section = match.group(1)
                current_content = []
            elif current_section:
                current_content.append(line)

        # Save last section
        if current_section:
            sections[current_section] = '\n'.join(current_content).strip()

        return sections

    def generate_tags(self, file_path: Path, metadata: Dict, sections: Dict) -> List[str]:
        """Generate appropriate tags for the memory"""
        tags = ['context-migration', 'historical']

        # Extract project from filename or metadata
        filename = file_path.stem
        project = self.extract_project_from_filename(filename)
        if project:
            tags.append(f"project:{project}")

        # Add branch/feature tags
        if 'feature-' in filename:
            tags.append('feature-branch')
        elif 'fix-' in filename:
            tags.append('bugfix')
        elif 'refactor-' in filename:
            tags.append('refactoring')
        elif 'master' in filename:
            tags.append('main-branch')

        # Add date tag if available
        if 'original_saved_date' in metadata:
            try:
                # Extract date from saved string
                date_match = re.search(r'(\d{4}-\d{2}-\d{2})', metadata['original_saved_date'])
                if date_match:
                    tags.append(f"session:{date_match.group(1)}")
            except:
                pass

        # Add section-based tags
        if 'Work Completed This Session' in sections:
            tags.append('completed-work')
        if 'Work In Progress' in sections:
            tags.append('work-in-progress')
        if 'Current Todos' in sections:
            tags.append('todos')
        if 'Key Problem Solved' in sections:
            tags.append('problem-solution')

        return tags

    def extract_project_from_filename(self, filename: str) -> Optional[str]:
        """Extract CB project from filename"""
        project_mappings = {
            'astro-sites': 'astro-sites',
            'requestdesk': 'cb-requestdesk',
            'shopify': 'cb-shopify',
            'wordpress': 'cb-wordpress',
            'magento': 'cb-magento',
            'junogo': 'cb-junogo',
            'jobs': 'jobs'
        }

        filename_lower = filename.lower()
        for pattern, project in project_mappings.items():
            if pattern in filename_lower:
                return project

        return None

    def determine_memory_sector(self, sections: Dict, tags: List[str]) -> str:
        """Determine the primary memory sector for classification"""
        # Problem solutions -> Procedural
        if 'problem-solution' in tags or 'Key Problem Solved' in sections:
            return 'procedural'

        # Architecture or design decisions -> Semantic
        if any('architecture' in s.lower() or 'design' in s.lower()
               for s in sections.keys()):
            return 'semantic'

        # Session work -> Episodic
        if 'session:' in ' '.join(tags) or 'Work Completed This Session' in sections:
            return 'episodic'

        # Default to episodic for context files
        return 'episodic'

    def create_memory_from_context(self, parsed_data: Dict) -> bool:
        """Create a memory in OpenMemory from parsed context data"""

        # Create separate memories for different sections to improve searchability
        memories_created = 0

        # Main context memory (full content)
        main_memory = {
            'content': parsed_data['content'],
            'tags': parsed_data['tags'] + ['full-context'],
            'metadata': {
                **parsed_data['metadata'],
                'memory_type': 'full_context',
                'sections': list(parsed_data['sections'].keys())
            },
            'user_id': USER_ID
        }

        if self.store_memory(main_memory):
            memories_created += 1

        # Create focused memories for key sections
        key_sections = [
            'Work Completed This Session',
            'Key Problem Solved',
            'Current Todos',
            'Next Steps'
        ]

        for section_name in key_sections:
            if section_name in parsed_data['sections']:
                section_content = parsed_data['sections'][section_name]
                if len(section_content.strip()) > 20:  # Only create if substantial content

                    section_memory = {
                        'content': f"## {section_name}\n\n{section_content}",
                        'tags': parsed_data['tags'] + [f'section:{section_name.lower().replace(" ", "-")}'],
                        'metadata': {
                            **parsed_data['metadata'],
                            'memory_type': 'section_focused',
                            'section_name': section_name,
                            'parent_context': parsed_data['metadata']['source_file']
                        },
                        'user_id': USER_ID
                    }

                    if self.store_memory(section_memory):
                        memories_created += 1

        return memories_created > 0

    def store_memory(self, memory_data: Dict) -> bool:
        """Store a single memory via OpenMemory API"""
        try:
            response = self.session.post(f"{API_URL}/memory/add", json=memory_data)

            if response.status_code == 200:
                result = response.json()
                print(f"  ✅ Memory stored: {result.get('id', 'unknown')} ({result.get('primary_sector', 'unknown')} sector)")
                return True
            else:
                print(f"  ❌ Failed to store memory: {response.status_code}")
                return False

        except requests.RequestException as e:
            print(f"  ❌ Network error: {e}")
            return False

    def import_file(self, file_path: Path) -> bool:
        """Import a single context file"""
        print(f"\n📄 Processing: {file_path.name}")

        try:
            parsed_data = self.parse_context_file(file_path)
            success = self.create_memory_from_context(parsed_data)

            if success:
                self.imported_count += 1
                print(f"  ✅ Successfully imported with tags: {', '.join(parsed_data['tags'])}")
            else:
                self.failed_count += 1
                print(f"  ❌ Failed to import")

            return success

        except Exception as e:
            self.failed_count += 1
            print(f"  ❌ Error processing file: {e}")
            return False

    def import_all_contexts(self, context_dir: Path, backup: bool = True) -> None:
        """Import all context files from directory"""
        if not context_dir.exists():
            print(f"❌ Context directory not found: {context_dir}")
            return

        # Create backup if requested
        if backup:
            self.create_backup(context_dir)

        # Find all markdown files
        context_files = list(context_dir.glob("*.md"))
        if not context_files:
            print(f"❌ No .md files found in {context_dir}")
            return

        print(f"🔍 Found {len(context_files)} context files to import")

        for file_path in sorted(context_files):
            # Skip README files
            if file_path.name.lower() in ['readme.md', 'template.md']:
                print(f"⏭️  Skipping: {file_path.name}")
                continue

            self.import_file(file_path)

        print(f"\n📊 Import Summary:")
        print(f"  ✅ Imported: {self.imported_count}")
        print(f"  ❌ Failed: {self.failed_count}")
        print(f"  📁 Total processed: {self.imported_count + self.failed_count}")

    def create_backup(self, context_dir: Path) -> None:
        """Create backup of context files"""
        backup_dir = Path(__file__).parent / 'backup' / datetime.now().strftime('%Y%m%d_%H%M%S')
        backup_dir.mkdir(parents=True, exist_ok=True)

        import shutil
        for file_path in context_dir.glob("*.md"):
            shutil.copy2(file_path, backup_dir / file_path.name)

        print(f"💾 Backup created: {backup_dir}")

def main():
    parser = argparse.ArgumentParser(description='Import CB-Workspace context files to OpenMemory')
    parser.add_argument('--context-dir',
                       default='/Users/brent/scripts/CB-Workspace/.claude/branch-context',
                       help='Directory containing context files')
    parser.add_argument('--no-backup', action='store_true',
                       help='Skip creating backup of context files')
    parser.add_argument('--file', help='Import single file instead of directory')

    args = parser.parse_args()

    importer = ContextImporter()

    # Check server
    if not importer.check_server():
        print("❌ OpenMemory server is not running at http://localhost:8080")
        print("💡 Start server: cd /Users/brent/scripts/OpenMemory/backend && npm run dev")
        return

    print("✅ OpenMemory server is running")

    if args.file:
        # Import single file
        file_path = Path(args.file)
        if not file_path.exists():
            print(f"❌ File not found: {file_path}")
            return

        importer.import_file(file_path)
    else:
        # Import all files from directory
        context_dir = Path(args.context_dir)
        importer.import_all_contexts(context_dir, backup=not args.no_backup)

if __name__ == '__main__':
    main()