# Optionally set dmenu command to use (parameters)
dmenu_cmd %q!dmenu -i -fn 'xft:Terminus:pixelsize=8' -nb '#000000' -nf '#FFFFFF' -sb '#0066ff'!

# COMMAND DEFINITIONS
# Commands are defined with 'cmd' command.  They will appear in dmenu
# in the order given.

# There are currently 3 styles of commands:
#cmd :application
#Executes 'application'.  Can be "Execute this" or any other valid Ruby,
#and either a string or a symbol

#cmd :name, 'execute this'
#Executes 'execute this' but displays in the menu as 'name' (still,
#name can be a string or a symbol)

#cmd :vncviewer do
#  host = dmenu %w{host:0 other-host:1}
#  "vncviewer #{host}"
#end
#Defines menu entry 'vncviewer', executing the block given when it's called.
#If the block returns a string, that string will be executed.
