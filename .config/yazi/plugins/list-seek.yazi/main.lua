--- @sync entry
-- https://github.com/sxyazi/yazi/issues/1327

return {
  entry = function(_, job)
    local folder = cx.active.current
    local total = #folder.files - 1
    if total <= 0 then
      return
    end

    local step = tonumber(job.args[1])
    local start = folder.window[1].idx - 1 + rt.mgr.scrolloff
    local end_ = folder.window[#folder.window].idx - 1 - rt.mgr.scrolloff

    local bound
    if step > 0 then
      bound = { math.min(total, start + step), math.min(total, end_ + step) }
    else
      bound = { math.max(0, start + step), math.max(0, end_ + step) }
    end

    local target = step > 0 and bound[2] or bound[1]
    local delta = target - folder.cursor
    for _ = 1, math.abs(delta) do
      ya.emit("arrow", { delta > 0 and 1 or -1 })
    end

    ya.emit("arrow", {
      ya.clamp(bound[1], folder.cursor, bound[2]) - target,
    })
  end,
}
