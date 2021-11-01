function hook(varlist)
  if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|vending") then
    if varlist[1]:match("expectprice|%d+") then
      expectprice = varlist[93]:match("expectprice|(%d+)")
      buycount = 93
    else
      expectprice = varlist[93]:match("expectprice|(-%d+)")
      buycount = varlist[93]:match("expectprice|(-%d+)"):sub(2)
    end
    sendPacket(false, ("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nexpectprice|%d|\nexpectitem|%d|\nbuycount|%d"):format(varlist[1]:match("tilex|(%d+)"), varlist[1]:match("tiley|(%d+)"), expectprice, varlist[1]:match("expectitem|(%d+)"), buycount), 2)
    return true
  end
end

addHook("OnVarlist", "fastbuy", hook)