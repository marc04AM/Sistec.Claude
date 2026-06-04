import json, sys, os, re

try:
    d = json.load(sys.stdin)
    cmd = d.get('tool_input', {}).get('command', '')
    if re.search(r'grep|rg |ripgrep|find |fd |ack |ag ', cmd) and os.path.exists('graphify-out/graph.json'):
        print(json.dumps({
            'hookSpecificOutput': {
                'hookEventName': 'PreToolUse',
                'additionalContext': (
                    'graphify: knowledge graph at graphify-out/. '
                    'Run graphify query "<question>" (scoped subgraph) instead of grepping raw files. '
                    'Read GRAPH_REPORT.md only for broad architecture context.'
                )
            }
        }))
except Exception:
    pass
