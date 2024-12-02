local yazi = require("yazi")

yazi.setup({
	floating_window_scaling_factor = 0.8,
	yazi_floating_window_winblend = 0,
})

local function convert_latest_files(count)
	local downloads_dir = os.getenv("HOME") .. "/Downloads"
	local public_dir = vim.fn.getcwd() .. "/public/assets"

	local latest_files = vim.fn.systemlist("ls -t " .. downloads_dir .. " | head -n " .. count)

	if #latest_files == 0 then
		print("No files found in Downloads.")
		return
	end

	for _, latest_file in ipairs(latest_files) do
		local source = downloads_dir .. "/" .. latest_file

		local file_type = vim.fn.system("file --mime-type -b " .. source .. " 2>/dev/null")

		if file_type:match("image/.*") then
			local target = public_dir .. "/" .. vim.fn.fnamemodify(latest_file, ":r") .. ".webp"
			local ffmpeg_cmd = "ffmpeg -y -i " .. source .. " -qscale:v 100 " .. target .. " >/dev/null 2>&1"
			local result = os.execute(ffmpeg_cmd)

			if result == 0 then
				print("Image converted and copied: " .. target)
			else
				print("Failed to convert image: " .. latest_file)
			end
		elseif file_type:match("video/.*") then
			local target = public_dir .. "/" .. vim.fn.fnamemodify(latest_file, ":r") .. ".webm"
			local ffmpeg_cmd = "ffmpeg -y -i "
				.. source
				.. " -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus "
				.. target
				.. " >/dev/null 2>&1"
			local result = os.execute(ffmpeg_cmd)

			if result == 0 then
				print("Video converted and copied: " .. target)
			else
				print("Failed to convert video: " .. latest_file)
			end
		else
			print("Unsupported file type: " .. latest_file)
		end
	end
end

local function convert_with_count()
	local input = vim.fn.input("Enter number of files to process: ")
	local count = tonumber(input)

	if count and count > 0 then
		convert_latest_files(count)
	else
		convert_latest_files(1)
	end
end

vim.keymap.set("n", "<leader>yf", convert_with_count, { noremap = true, silent = true, desc = "Convert latest files" })
vim.keymap.set("n", "<leader>yy", yazi.yazi, { noremap = true, silent = true, desc = "Open yazi in current directory" })
vim.keymap.set(
	"n",
	"<leader>yd",
	function() yazi.yazi(nil, "~/Downloads") end,
	{ noremap = true, silent = true, desc = "Open yazi in Downloads" }
)
