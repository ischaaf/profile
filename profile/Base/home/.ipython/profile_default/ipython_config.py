c = get_config()

c.InteractiveShellApp.extensions.append("autoreload")
c.InteractiveShellApp.exec_lines = ["%autoreload 2"]
