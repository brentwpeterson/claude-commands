# Frontend Architecture (React)

## ⚠️ CRITICAL: NO MUI COMPONENTS

**DO NOT use Material-UI (MUI) components for new development.**

Use instead:
- **Tailwind CSS** for styling
- **Catalyst UI Kit** for components (`/frontend/src/components/tailwind-ui/catalyst-ui-kit/`)
- **HeadlessUI** for accessible primitives
- **TanStack Table** for data tables

Legacy MUI exists in the codebase but all new features must use Tailwind/Catalyst.

## Directory Structure

```
frontend/src/
├── App.tsx                 # Main React Admin app
├── index.tsx               # Entry point
├── components/
│   ├── tailwind-ui/        # Tailwind-based components
│   │   └── catalyst-ui-kit/  # Catalyst UI components
│   ├── agents/             # Agent-related components
│   ├── campaigns/          # Campaign components
│   ├── tickets/            # Ticket components
│   ├── integrations/       # Shopify, WordPress, etc.
│   └── common/             # Shared components
├── pages/                  # Full page components
├── providers/              # React context providers
├── hooks/                  # Custom React hooks
├── services/               # API service functions
├── dataProvider/           # React Admin data provider
└── utils/                  # Utility functions
```

## Component Pattern (Tailwind/Catalyst)

```tsx
// ✅ CORRECT: Using Tailwind CSS
export function FeatureCard({ title, description }: Props) {
  return (
    <div className="rounded-lg border border-gray-200 bg-white p-6 shadow-sm">
      <h3 className="text-lg font-semibold text-gray-900">{title}</h3>
      <p className="mt-2 text-sm text-gray-600">{description}</p>
      <button className="mt-4 rounded-md bg-blue-600 px-4 py-2 text-white hover:bg-blue-700">
        Learn More
      </button>
    </div>
  );
}

// ❌ WRONG: Using MUI
import { Card, Typography, Button } from '@mui/material';
// DO NOT USE MUI FOR NEW COMPONENTS
```

## Catalyst UI Components

**Location**: `frontend/src/components/tailwind-ui/catalyst-ui-kit/typescript/`
**Documentation**: https://catalyst.tailwindui.com/docs
**Built by**: Tailwind CSS team (part of Tailwind Plus)

**Dependencies** (already installed):
- `@headlessui/react` - Accessible UI primitives
- `framer-motion` - Animations
- `clsx` - Conditional classnames
- `tailwindcss` v4.0+

**Available components**:
- `Button` - Primary, secondary, outline variants
- `Input` - Form inputs with labels
- `Field`, `FieldGroup`, `Label` - Form field wrappers
- `Select` - Dropdowns
- `Dialog` - Modal dialogs
- `Table` - Basic tables
- `Badge` - Status badges
- `Alert` - Notifications

```tsx
import { Button } from '@/components/tailwind-ui/catalyst-ui-kit/typescript/button';
import { Input } from '@/components/tailwind-ui/catalyst-ui-kit/typescript/input';

export function MyForm() {
  return (
    <form className="space-y-4">
      <Input label="Name" name="name" />
      <Button type="submit">Save</Button>
    </form>
  );
}
```

## TanStack Table for Data

```tsx
import { useReactTable, getCoreRowModel, flexRender } from '@tanstack/react-table';

export function DataTable({ data, columns }) {
  const table = useReactTable({
    data,
    columns,
    getCoreRowModel: getCoreRowModel(),
  });

  return (
    <table className="min-w-full divide-y divide-gray-200">
      <thead className="bg-gray-50">
        {table.getHeaderGroups().map(headerGroup => (
          <tr key={headerGroup.id}>
            {headerGroup.headers.map(header => (
              <th key={header.id} className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">
                {flexRender(header.column.columnDef.header, header.getContext())}
              </th>
            ))}
          </tr>
        ))}
      </thead>
      <tbody className="bg-white divide-y divide-gray-200">
        {table.getRowModel().rows.map(row => (
          <tr key={row.id}>
            {row.getVisibleCells().map(cell => (
              <td key={cell.id} className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                {flexRender(cell.column.columnDef.cell, cell.getContext())}
              </td>
            ))}
          </tr>
        ))}
      </tbody>
    </table>
  );
}
```

## React Admin Integration

RequestDesk uses React Admin as the base framework:

```tsx
import { Admin, Resource, ListGuesser } from 'react-admin';
import { dataProvider } from './dataProvider';

function App() {
  return (
    <Admin dataProvider={dataProvider}>
      <Resource name="users" list={UserList} edit={UserEdit} />
      <Resource name="agents" list={AgentList} edit={AgentEdit} />
    </Admin>
  );
}
```

## DataProvider Pattern

The dataProvider handles all API communication:

```tsx
// frontend/src/dataProvider/index.ts
export const dataProvider = {
  getList: async (resource, params) => {
    const response = await fetch(`/api/${resource}?...`);
    return { data: response.data, total: response.total };
  },
  getOne: async (resource, params) => {
    const response = await fetch(`/api/${resource}/${params.id}`);
    return { data: response };
  },
  create: async (resource, params) => {
    const response = await fetch(`/api/${resource}`, {
      method: 'POST',
      body: JSON.stringify(params.data),
    });
    return { data: response };
  },
  // ... update, delete, etc.
};
```

## API Calls (Outside React Admin)

For custom API calls not through React Admin:

```tsx
// ✅ CORRECT: Relative URLs
const response = await fetch('/api/agents/123/chat', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ message: 'Hello' }),
});

// ❌ WRONG: Hardcoded URLs (breaks production)
const response = await fetch('http://localhost:3000/api/agents/123/chat', ...);
```

## Brand Colors

- Primary Blue: `bg-blue-600`, `text-blue-600`
- Use Tailwind's blue palette for RequestDesk branding

## Key Patterns

### Loading States
```tsx
const [loading, setLoading] = useState(true);

if (loading) {
  return <div className="animate-pulse">Loading...</div>;
}
```

### Error Handling
```tsx
const [error, setError] = useState<string | null>(null);

if (error) {
  return <div className="text-red-600">{error}</div>;
}
```

### Form Handling
```tsx
const [formData, setFormData] = useState({ name: '', email: '' });

const handleSubmit = async (e: React.FormEvent) => {
  e.preventDefault();
  await fetch('/api/resource', {
    method: 'POST',
    body: JSON.stringify(formData),
  });
};
```
