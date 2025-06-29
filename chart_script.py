import plotly.graph_objects as go
import plotly.express as px
import json
import numpy as np

# Parse the data and add missing subdirectories from instructions
data = {"nodes": [
    {"id": "project", "label": "project/", "level": 0, "category": "root"},
    {"id": "claude", "label": ".claude/", "level": 1, "category": "config", "parent": "project"},
    {"id": "workflows", "label": "workflows/", "level": 1, "category": "process", "parent": "project"},
    {"id": "commands", "label": "commands/", "level": 1, "category": "actions", "parent": "project"},
    {"id": "patterns", "label": "patterns/", "level": 1, "category": "templates", "parent": "project"},
    {"id": "memory", "label": "memory/", "level": 1, "category": "context", "parent": "project"},
    {"id": "shared", "label": "shared/", "level": 1, "category": "utilities", "parent": "project"},
    {"id": "specialists", "label": "specialists/", "level": 2, "category": "config", "parent": "claude"},
    {"id": "cognitive", "label": "cognitive/", "level": 3, "category": "config", "parent": "specialists"},
    {"id": "technical", "label": "technical/", "level": 3, "category": "config", "parent": "specialists"},
    {"id": "domain", "label": "domain/", "level": 3, "category": "config", "parent": "specialists"},
    {"id": "orchestration_spec", "label": "orchestration/", "level": 3, "category": "config", "parent": "specialists"},
    {"id": "development", "label": "development/", "level": 2, "category": "process", "parent": "workflows"},
    {"id": "analysis", "label": "analysis/", "level": 2, "category": "process", "parent": "workflows"},
    {"id": "operations", "label": "operations/", "level": 2, "category": "process", "parent": "workflows"},
    {"id": "core", "label": "core/", "level": 2, "category": "actions", "parent": "commands"},
    {"id": "specialized", "label": "specialized/", "level": 2, "category": "actions", "parent": "commands"},
    {"id": "orchestration_cmd", "label": "orchestration/", "level": 2, "category": "actions", "parent": "commands"},
    {"id": "architectural", "label": "architectural/", "level": 2, "category": "templates", "parent": "patterns"},
    {"id": "development_pat", "label": "development/", "level": 2, "category": "templates", "parent": "patterns"},
    {"id": "operational", "label": "operational/", "level": 2, "category": "templates", "parent": "patterns"},
    {"id": "context", "label": "context/", "level": 2, "category": "context", "parent": "memory"},
    {"id": "sessions", "label": "sessions/", "level": 2, "category": "context", "parent": "memory"},
    {"id": "knowledge", "label": "knowledge/", "level": 2, "category": "context", "parent": "memory"},
    {"id": "mcp-integration", "label": "mcp-integration/", "level": 2, "category": "utilities", "parent": "shared"},
    {"id": "templates", "label": "templates/", "level": 2, "category": "utilities", "parent": "shared"},
    {"id": "utilities", "label": "utilities/", "level": 2, "category": "utilities", "parent": "shared"}
]}

nodes = data['nodes']

# Define colors for categories with better distinction
colors = {
    'root': '#13343B',        # Dark cyan for root
    'config': '#4472C4',      # Blue
    'process': '#70AD47',     # Green
    'actions': '#FF7F50',     # Orange
    'templates': '#9966CC',   # Purple
    'context': '#DC143C',     # Red
    'utilities': '#5D878F'    # Cyan-gray
}

# Create improved hierarchical layout with much better spacing
def create_hierarchical_layout(nodes):
    positions = {}
    
    # Position root node at top center
    root_node = [n for n in nodes if n['level'] == 0][0]
    positions[root_node['id']] = (0, 0)
    
    # Position level 1 nodes (main directories) with wider spacing
    level1_nodes = [n for n in nodes if n['level'] == 1]
    level1_spacing = 4.5  # Increased spacing
    start_x = -(len(level1_nodes) - 1) * level1_spacing / 2
    
    for i, node in enumerate(level1_nodes):
        x = start_x + i * level1_spacing
        y = -3.5  # More vertical space
        positions[node['id']] = (x, y)
    
    # Position level 2 nodes under their parents with better spacing
    level2_nodes = [n for n in nodes if n['level'] == 2]
    for node in level2_nodes:
        parent_id = node['parent']
        parent_pos = positions[parent_id]
        
        # Get siblings (nodes with same parent)
        siblings = [n for n in level2_nodes if n.get('parent') == parent_id]
        sibling_index = siblings.index(node)
        
        # Calculate position with better spacing
        if len(siblings) == 1:
            x_offset = 0
        else:
            sibling_spacing = 1.8  # Increased spacing between siblings
            start_offset = -(len(siblings) - 1) * sibling_spacing / 2
            x_offset = start_offset + sibling_index * sibling_spacing
        
        x = parent_pos[0] + x_offset
        y = parent_pos[1] - 3.5  # More vertical space
        positions[node['id']] = (x, y)
    
    # Position level 3 nodes under their parents
    level3_nodes = [n for n in nodes if n['level'] == 3]
    for node in level3_nodes:
        parent_id = node['parent']
        parent_pos = positions[parent_id]
        
        # Get siblings
        siblings = [n for n in level3_nodes if n.get('parent') == parent_id]
        sibling_index = siblings.index(node)
        
        # Calculate position
        if len(siblings) == 1:
            x_offset = 0
        else:
            sibling_spacing = 1.5
            start_offset = -(len(siblings) - 1) * sibling_spacing / 2
            x_offset = start_offset + sibling_index * sibling_spacing
        
        x = parent_pos[0] + x_offset
        y = parent_pos[1] - 3.0
        positions[node['id']] = (x, y)
    
    return positions

node_positions = create_hierarchical_layout(nodes)

# Create figure
fig = go.Figure()

# Add connecting lines with better styling
for node in nodes:
    if 'parent' in node:
        parent_id = node['parent']
        child_pos = node_positions[node['id']]
        parent_pos = node_positions[parent_id]
        
        # Add line from parent to child
        fig.add_trace(go.Scatter(
            x=[parent_pos[0], child_pos[0]],
            y=[parent_pos[1], child_pos[1]],
            mode='lines',
            line=dict(color='#CCCCCC', width=1.5),
            showlegend=False,
            hoverinfo='skip'
        ))

# Add nodes with better sizing and text positioning
for category in colors:
    category_nodes = [node for node in nodes if node['category'] == category]
    if category_nodes:
        x_coords = [node_positions[node['id']][0] for node in category_nodes]
        y_coords = [node_positions[node['id']][1] for node in category_nodes]
        labels = [node['label'] for node in category_nodes]
        
        # Adjust marker size based on level
        marker_sizes = []
        for node in category_nodes:
            if node['level'] == 0:
                marker_sizes.append(40)  # Larger root
            elif node['level'] == 1:
                marker_sizes.append(28)  # Main directories
            else:
                marker_sizes.append(22)  # Subdirectories
        
        fig.add_trace(go.Scatter(
            x=x_coords,
            y=y_coords,
            mode='markers+text',
            marker=dict(
                size=marker_sizes,
                color=colors[category],
                line=dict(color='white', width=2)
            ),
            text=labels,
            textposition='bottom center',
            textfont=dict(size=10, color='black', family='Arial'),
            name=category.title(),
            hovertemplate='%{text}<extra></extra>',
            cliponaxis=False
        ))

# Update layout with optimized spacing
fig.update_layout(
    title="Claude Code & MCP Structure",
    showlegend=True,
    legend=dict(orientation='h', yanchor='bottom', y=1.05, xanchor='center', x=0.5),
    xaxis=dict(
        showgrid=False, 
        zeroline=False, 
        showticklabels=False, 
        range=[-15, 15]  # Wider range for better spacing
    ),
    yaxis=dict(
        showgrid=False, 
        zeroline=False, 
        showticklabels=False, 
        range=[-12, 2]  # Taller range for better spacing
    ),
    plot_bgcolor='white',
    paper_bgcolor='white'
)

# Hide axes without using cliponaxis
fig.update_xaxes(visible=False)
fig.update_yaxes(visible=False)

# Save the chart with higher resolution
fig.write_image("claude_mcp_structure.png", width=1600, height=1000)