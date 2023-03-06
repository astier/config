local gx =  {}

function gx.gx()
	require('various-textobjs').url() -- select URL
	local foundURL = vim.fn.mode():find('v') -- only switches to visual mode if found
	if foundURL then
		vim.cmd.normal { '"zy', bang = true } -- retrieve URL with "z as intermediary
		local url = vim.fn.getreg('z')
		os.execute('$BROWSER ' .. "'" .. url .. "'")
	end
end

return gx
