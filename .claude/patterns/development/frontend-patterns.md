# Frontend Development Patterns

## Pattern Name & Overview

**Frontend Patterns** encompass design patterns, architectural approaches, and best practices for building modern, maintainable, and performant user interfaces. These patterns address common challenges in state management, component organization, performance optimization, and user experience.

## Problem Context (When to Use)

Apply frontend patterns when:
- Building complex single-page applications (SPAs)
- Managing application state across multiple components
- Optimizing performance for large-scale applications
- Ensuring consistent user experience across devices
- Implementing reusable component libraries
- Handling asynchronous data flows
- Managing form validation and user input

## Solution

Frontend patterns are organized into several categories:

1. **Component Patterns**: Structuring and organizing UI components
2. **State Management Patterns**: Managing application state effectively
3. **Performance Patterns**: Optimizing rendering and load times
4. **Data Fetching Patterns**: Handling API calls and caching
5. **Routing Patterns**: Managing navigation and deep linking
6. **Form Patterns**: Handling user input and validation

## Implementation Guidelines

### 1. Component Patterns

#### Container/Presentational Pattern
```javascript
// Presentational Component (Pure UI)
const UserCard = ({ user, onEdit, onDelete }) => (
  <div className="user-card">
    <h3>{user.name}</h3>
    <p>{user.email}</p>
    <button onClick={() => onEdit(user.id)}>Edit</button>
    <button onClick={() => onDelete(user.id)}>Delete</button>
  </div>
);

// Container Component (Business Logic)
const UserCardContainer = ({ userId }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchUser(userId).then(data => {
      setUser(data);
      setLoading(false);
    });
  }, [userId]);

  const handleEdit = (id) => {
    // Business logic for editing
  };

  const handleDelete = (id) => {
    // Business logic for deletion
  };

  if (loading) return <Spinner />;
  return <UserCard user={user} onEdit={handleEdit} onDelete={handleDelete} />;
};
```

#### Compound Component Pattern
```javascript
// Compound components for flexible composition
const Tabs = ({ children, defaultTab }) => {
  const [activeTab, setActiveTab] = useState(defaultTab);

  return (
    <TabContext.Provider value={{ activeTab, setActiveTab }}>
      <div className="tabs">{children}</div>
    </TabContext.Provider>
  );
};

Tabs.List = ({ children }) => (
  <div className="tabs-list">{children}</div>
);

Tabs.Tab = ({ id, children }) => {
  const { activeTab, setActiveTab } = useContext(TabContext);
  return (
    <button
      className={activeTab === id ? 'active' : ''}
      onClick={() => setActiveTab(id)}
    >
      {children}
    </button>
  );
};

Tabs.Panel = ({ id, children }) => {
  const { activeTab } = useContext(TabContext);
  return activeTab === id ? <div className="tab-panel">{children}</div> : null;
};

// Usage
<Tabs defaultTab="profile">
  <Tabs.List>
    <Tabs.Tab id="profile">Profile</Tabs.Tab>
    <Tabs.Tab id="settings">Settings</Tabs.Tab>
  </Tabs.List>
  <Tabs.Panel id="profile"><ProfileContent /></Tabs.Panel>
  <Tabs.Panel id="settings"><SettingsContent /></Tabs.Panel>
</Tabs>
```

### 2. State Management Patterns

#### Redux Pattern with Redux Toolkit
```javascript
// Store configuration
import { configureStore, createSlice } from '@reduxjs/toolkit';

// Feature slice
const todosSlice = createSlice({
  name: 'todos',
  initialState: {
    items: [],
    loading: false,
    error: null
  },
  reducers: {
    addTodo: (state, action) => {
      state.items.push({
        id: Date.now(),
        text: action.payload,
        completed: false
      });
    },
    toggleTodo: (state, action) => {
      const todo = state.items.find(item => item.id === action.payload);
      if (todo) todo.completed = !todo.completed;
    }
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchTodos.pending, (state) => {
        state.loading = true;
      })
      .addCase(fetchTodos.fulfilled, (state, action) => {
        state.loading = false;
        state.items = action.payload;
      })
      .addCase(fetchTodos.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message;
      });
  }
});

// Async thunk
const fetchTodos = createAsyncThunk('todos/fetch', async () => {
  const response = await fetch('/api/todos');
  return response.json();
});

// Store setup
const store = configureStore({
  reducer: {
    todos: todosSlice.reducer
  }
});
```

#### Context + useReducer Pattern
```javascript
// State management without external libraries
const StateContext = createContext();

const stateReducer = (state, action) => {
  switch (action.type) {
    case 'SET_USER':
      return { ...state, user: action.payload };
    case 'SET_THEME':
      return { ...state, theme: action.payload };
    case 'TOGGLE_SIDEBAR':
      return { ...state, sidebarOpen: !state.sidebarOpen };
    default:
      return state;
  }
};

export const StateProvider = ({ children }) => {
  const [state, dispatch] = useReducer(stateReducer, {
    user: null,
    theme: 'light',
    sidebarOpen: true
  });

  const value = useMemo(() => ({ state, dispatch }), [state]);

  return (
    <StateContext.Provider value={value}>
      {children}
    </StateContext.Provider>
  );
};

// Custom hook for using state
export const useAppState = () => {
  const context = useContext(StateContext);
  if (!context) {
    throw new Error('useAppState must be used within StateProvider');
  }
  return context;
};
```

### 3. Performance Patterns

#### Code Splitting and Lazy Loading
```javascript
// Route-based code splitting
import { lazy, Suspense } from 'react';
import { Routes, Route } from 'react-router-dom';

const Dashboard = lazy(() => import('./pages/Dashboard'));
const Profile = lazy(() => import('./pages/Profile'));
const Settings = lazy(() => import('./pages/Settings'));

function App() {
  return (
    <Suspense fallback={<LoadingSpinner />}>
      <Routes>
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/profile" element={<Profile />} />
        <Route path="/settings" element={<Settings />} />
      </Routes>
    </Suspense>
  );
}

// Component-level lazy loading
const HeavyComponent = lazy(() => 
  import('./HeavyComponent')
    .then(module => ({ default: module.HeavyComponent }))
);
```

#### Virtualization Pattern
```javascript
// Virtual list for rendering large datasets
import { FixedSizeList } from 'react-window';

const VirtualizedList = ({ items }) => {
  const Row = ({ index, style }) => (
    <div style={style} className="list-item">
      {items[index].name}
    </div>
  );

  return (
    <FixedSizeList
      height={600}
      itemCount={items.length}
      itemSize={50}
      width="100%"
    >
      {Row}
    </FixedSizeList>
  );
};

// Virtualized table with dynamic sizing
import { VariableSizeGrid } from 'react-window';

const VirtualizedTable = ({ data, columns }) => {
  const Cell = ({ columnIndex, rowIndex, style }) => (
    <div style={style} className="table-cell">
      {data[rowIndex][columns[columnIndex].key]}
    </div>
  );

  return (
    <VariableSizeGrid
      columnCount={columns.length}
      columnWidth={index => columns[index].width}
      height={600}
      rowCount={data.length}
      rowHeight={() => 50}
      width={1000}
    >
      {Cell}
    </VariableSizeGrid>
  );
};
```

### 4. Data Fetching Patterns

#### React Query Pattern
```javascript
// Data fetching with caching and synchronization
import { useQuery, useMutation, useQueryClient } from 'react-query';

// Custom hook for data fetching
const useUsers = () => {
  return useQuery('users', fetchUsers, {
    staleTime: 5 * 60 * 1000, // 5 minutes
    cacheTime: 10 * 60 * 1000, // 10 minutes
    refetchOnWindowFocus: false,
    retry: 3,
    retryDelay: attemptIndex => Math.min(1000 * 2 ** attemptIndex, 30000)
  });
};

// Mutation with optimistic updates
const useUpdateUser = () => {
  const queryClient = useQueryClient();
  
  return useMutation(updateUser, {
    onMutate: async (newUser) => {
      await queryClient.cancelQueries(['user', newUser.id]);
      
      const previousUser = queryClient.getQueryData(['user', newUser.id]);
      
      queryClient.setQueryData(['user', newUser.id], newUser);
      
      return { previousUser };
    },
    onError: (err, newUser, context) => {
      queryClient.setQueryData(
        ['user', newUser.id],
        context.previousUser
      );
    },
    onSettled: (data, error, variables) => {
      queryClient.invalidateQueries(['user', variables.id]);
    }
  });
};

// Component using the hooks
const UserProfile = ({ userId }) => {
  const { data: user, isLoading, error } = useQuery(
    ['user', userId],
    () => fetchUser(userId)
  );
  
  const updateUserMutation = useUpdateUser();
  
  if (isLoading) return <Spinner />;
  if (error) return <ErrorMessage error={error} />;
  
  return (
    <div>
      <h1>{user.name}</h1>
      <button onClick={() => updateUserMutation.mutate({ ...user, name: 'New Name' })}>
        Update Name
      </button>
    </div>
  );
};
```

### 5. Form Patterns

#### Form Validation with React Hook Form
```javascript
// Advanced form handling
import { useForm, Controller } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import * as z from 'zod';

// Validation schema
const userSchema = z.object({
  username: z.string().min(3).max(20),
  email: z.string().email(),
  age: z.number().min(18).max(100),
  password: z.string().min(8).regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/),
  confirmPassword: z.string()
}).refine((data) => data.password === data.confirmPassword, {
  message: "Passwords don't match",
  path: ["confirmPassword"]
});

const RegistrationForm = () => {
  const {
    register,
    handleSubmit,
    control,
    formState: { errors, isSubmitting },
    watch
  } = useForm({
    resolver: zodResolver(userSchema),
    mode: 'onBlur'
  });

  const onSubmit = async (data) => {
    try {
      await registerUser(data);
    } catch (error) {
      console.error('Registration failed:', error);
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input
        {...register('username')}
        placeholder="Username"
        aria-invalid={errors.username ? 'true' : 'false'}
      />
      {errors.username && <span>{errors.username.message}</span>}

      <input
        {...register('email')}
        type="email"
        placeholder="Email"
      />
      {errors.email && <span>{errors.email.message}</span>}

      <Controller
        name="age"
        control={control}
        render={({ field }) => (
          <input
            {...field}
            type="number"
            placeholder="Age"
            onChange={(e) => field.onChange(parseInt(e.target.value))}
          />
        )}
      />

      <button type="submit" disabled={isSubmitting}>
        {isSubmitting ? 'Registering...' : 'Register'}
      </button>
    </form>
  );
};
```

## Code Examples

### Complete Frontend Architecture Example

```javascript
// App structure with all patterns combined
// src/App.jsx
import { QueryClient, QueryClientProvider } from 'react-query';
import { ReactQueryDevtools } from 'react-query/devtools';
import { Provider } from 'react-redux';
import { BrowserRouter } from 'react-router-dom';
import { ErrorBoundary } from 'react-error-boundary';
import { store } from './store';
import { ThemeProvider } from './contexts/ThemeContext';
import { AuthProvider } from './contexts/AuthContext';
import Router from './Router';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      refetchOnWindowFocus: false,
      retry: 1,
      staleTime: 5 * 60 * 1000
    }
  }
});

function ErrorFallback({ error, resetErrorBoundary }) {
  return (
    <div role="alert">
      <p>Something went wrong:</p>
      <pre>{error.message}</pre>
      <button onClick={resetErrorBoundary}>Try again</button>
    </div>
  );
}

function App() {
  return (
    <ErrorBoundary FallbackComponent={ErrorFallback}>
      <Provider store={store}>
        <QueryClientProvider client={queryClient}>
          <BrowserRouter>
            <ThemeProvider>
              <AuthProvider>
                <Router />
              </AuthProvider>
            </ThemeProvider>
          </BrowserRouter>
          <ReactQueryDevtools />
        </QueryClientProvider>
      </Provider>
    </ErrorBoundary>
  );
}

// src/hooks/useIntersectionObserver.js
// Custom hook for lazy loading
export function useIntersectionObserver({
  target,
  onIntersect,
  threshold = 0.1,
  rootMargin = '0px'
}) {
  useEffect(() => {
    const observer = new IntersectionObserver(
      entries => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            onIntersect();
          }
        });
      },
      { threshold, rootMargin }
    );

    const el = target.current;
    if (el) observer.observe(el);

    return () => {
      if (el) observer.unobserve(el);
    };
  }, [target, onIntersect, threshold, rootMargin]);
}

// src/components/LazyImage.jsx
// Progressive image loading
const LazyImage = ({ src, placeholder, alt, ...props }) => {
  const [imageSrc, setImageSrc] = useState(placeholder);
  const [imageRef, setImageRef] = useState();
  const [isLoaded, setIsLoaded] = useState(false);

  useIntersectionObserver({
    target: imageRef,
    onIntersect: () => {
      setImageSrc(src);
    }
  });

  return (
    <div ref={setImageRef} className="lazy-image-wrapper">
      <img
        src={imageSrc}
        alt={alt}
        onLoad={() => setIsLoaded(true)}
        className={`lazy-image ${isLoaded ? 'loaded' : 'loading'}`}
        {...props}
      />
    </div>
  );
};
```

## Benefits & Trade-offs

### Benefits
- **Maintainability**: Clear separation of concerns
- **Reusability**: Component-based architecture
- **Performance**: Optimized rendering and loading
- **Developer Experience**: Predictable patterns
- **Testability**: Isolated components and logic
- **Scalability**: Modular architecture

### Trade-offs
- **Complexity**: Learning curve for patterns
- **Bundle Size**: Framework and library overhead
- **Over-engineering**: Risk of premature optimization
- **Abstraction Cost**: Additional layers of indirection
- **Performance Overhead**: Virtual DOM and state management
- **Tool Fatigue**: Rapid ecosystem changes

## Common Pitfalls

1. **Prop Drilling**: Passing props through many levels
2. **Unnecessary Re-renders**: Missing memoization
3. **Memory Leaks**: Not cleaning up subscriptions
4. **Large Bundle Sizes**: Not implementing code splitting
5. **State Mismanagement**: Storing derived state
6. **Missing Error Boundaries**: Unhandled component errors
7. **Accessibility Neglect**: Missing ARIA attributes

## Integration with AugmentedClaude Specialists

### Frontend Developer
- Implements UI components and interactions
- Manages state and data flow
- Optimizes performance and bundle size

### UX Designer
- Creates design systems and component libraries
- Ensures consistent user experience
- Conducts usability testing

### Full Stack Developer
- Integrates frontend with backend APIs
- Implements authentication flows
- Manages deployment pipelines

### Quality Assurance Engineer
- Writes component and integration tests
- Performs cross-browser testing
- Validates accessibility compliance

## Related Patterns

- **Micro Frontends**: Independent frontend applications
- **JAMstack**: JavaScript, APIs, and Markup
- **Progressive Web Apps**: Offline-capable web apps
- **Server-Side Rendering**: Initial HTML from server
- **Static Site Generation**: Pre-built HTML pages
- **Island Architecture**: Partial hydration pattern

## Best Practices

1. **Component Design**
   ```javascript
   // Single Responsibility Principle
   const Button = ({ variant, size, onClick, children, ...props }) => {
     const className = clsx(
       'btn',
       `btn-${variant}`,
       `btn-${size}`,
       props.className
     );
     
     return (
       <button className={className} onClick={onClick} {...props}>
         {children}
       </button>
     );
   };
   ```

2. **Performance Optimization**
   ```javascript
   // Memoization for expensive computations
   const ExpensiveComponent = memo(({ data }) => {
     const processedData = useMemo(() => 
       expensiveProcessing(data), [data]
     );
     
     const handleClick = useCallback((id) => {
       // Handle click
     }, []);
     
     return <div>{/* Render processed data */}</div>;
   });
   ```

3. **Testing Strategy**
   ```javascript
   // Component testing
   describe('UserCard', () => {
     it('renders user information', () => {
       const user = { name: 'John', email: 'john@example.com' };
       render(<UserCard user={user} />);
       
       expect(screen.getByText(user.name)).toBeInTheDocument();
       expect(screen.getByText(user.email)).toBeInTheDocument();
     });
     
     it('calls onEdit when edit button clicked', () => {
       const handleEdit = jest.fn();
       const user = { id: 1, name: 'John' };
       
       render(<UserCard user={user} onEdit={handleEdit} />);
       fireEvent.click(screen.getByText('Edit'));
       
       expect(handleEdit).toHaveBeenCalledWith(user.id);
     });
   });
   ```

4. **Accessibility**
   ```javascript
   // Accessible form component
   const FormField = ({ label, error, required, ...inputProps }) => {
     const id = useId();
     const errorId = `${id}-error`;
     
     return (
       <div className="form-field">
         <label htmlFor={id}>
           {label}
           {required && <span aria-label="required">*</span>}
         </label>
         <input
           id={id}
           aria-invalid={error ? 'true' : 'false'}
           aria-describedby={error ? errorId : undefined}
           {...inputProps}
         />
         {error && (
           <span id={errorId} role="alert" className="error">
             {error}
           </span>
         )}
       </div>
     );
   };
   ```

5. **Build Configuration**
   ```javascript
   // Webpack optimization
   module.exports = {
     optimization: {
       splitChunks: {
         chunks: 'all',
         cacheGroups: {
           vendor: {
             test: /[\\/]node_modules[\\/]/,
             name: 'vendors',
             priority: 10
           },
           common: {
             minChunks: 2,
             priority: 5,
             reuseExistingChunk: true
           }
         }
       }
     }
   };
   ```

These patterns provide a solid foundation for building modern, scalable frontend applications with excellent user experience and developer ergonomics.