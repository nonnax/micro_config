-- Id$ nonnax 2022-07-04 11:46:47
local config = import("micro/config")
local shell = import("micro/shell")

function init()
  -- true means overwrite any existing binding to Ctrl-r
  -- this will modify the bindings.json file
  config.TryBindKey("Ctrl-r", "lua:initlua.gorun", true)
end

function gorun(bp)
  local buf = bp.Buf
  local c = bp.Cursor  
  if buf:FileType() == "lua" then

    if not c:HasSelection() then
			c:SelectWord()
		end

--		if c:HasSelection() then
--		sel = c:GetSelection()
--			cmd = strings.Replace(cmd, "{s}", sel, 1)
--		end
    -- the true means run in the foreground
    -- the false means send output to stdout (instead of returning it)
  --  shell.RunInteractiveShell("lua " .. buf.Path, true, false)
  elseif buf:FileType() == "ruby" then
    -- the true means run in the foreground
    -- the false means send output to stdout (instead of returning it)
    shell.RunInteractiveShell("ruby " .. buf.Path, true, false)
  end
end

--	local c = bp.Cursor
--	local cmd = ""
--	cmd = strings.Join(args, " ")
--
--	if strings.Contains(cmd, "{s}") then
--		if c:HasSelection() then
--			sel = c:GetSelection()
--			cmd = strings.Replace(cmd, "{s}", sel, 1)
--		end
--	end
--
--	if strings.Contains(cmd, "{w}") then
--		local sel = ""
--		if not c:HasSelection() then
--			c:SelectWord()
--		end
--		sel = c:GetSelection()
--		cmd = strings.Replace(cmd, "{w}", sel, 1)
