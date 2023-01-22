local M = {}

M.merge = function (base, override)
  local result = {}
  for k, v in ipairs(base)
  do
    result[k] = v
  end
  for k, v in ipairs(override)
  do
    result[k] = v
  end
  return result
end

return M
