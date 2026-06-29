local function remove_dups(list)
  local set = {}
  local uniques = {}
  for _, item in ipairs(list) do
    if not set[item] then
      set[item] = true
      table.insert(uniques, item)
    end
  end
  return uniques
end
meta_h.remove_dups = remove_dups
