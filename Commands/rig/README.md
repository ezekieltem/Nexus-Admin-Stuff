There are 2 methods
1. Get the [latest source code for NexusAdmin](https://github.com/TheNexusAvenger/Nexus-Admin/releases) *(or use a pre-existing one if your game already has the source code)*.
   - Put the code within a `ModuleScript`
   - Parent said `ModuleScript` to "__MainModule.NexusAdmin.IncludedCommands.UsefulFun__"
2. Use [@ezekieltem's custom NexusAdmin MainModule](https://create.roblox.com/store/asset/15410508172).
   - Put the code within a `ModuleScript`
   - Name said `ModuleScript` "__NexusAdmin.IncludedCommands.UsefulFun.rig__"
   - parent said `ModuleScript` to "__NexusAdminLoader.Internal_Overrides.Overrides__".
   - Open "__NexusAdminLoader.Internal_Overrides.Settings__"
   - Add the following code under the respective priority
```lua
["NexusAdmin.IncludedCommands.UsefulFun.rig"] = {
MigrateChildren = false
}
```

If you have any questions feel free to DM me on discord **ezekieltem** *(ezekieltem#3012)*
