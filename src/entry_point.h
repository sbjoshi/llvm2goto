/* Copyright
Author : Rasika

*/

#include "ansi-c/ansi_c_entry_point.h"
#include "cbmc/cbmc_parse_options.h"
#include <linking/static_lifetime_init.h>

void set_function_symbol_value(
  goto_functionst::function_mapt &function_map,
  symbol_tablet &symbol_table)
{
  for(typename goto_functionst::function_mapt::iterator
      it=function_map.begin();
      it!=function_map.end();
      it++)
  {
    goto_programt::instructionst instructions = it->second.body.instructions;
    code_blockt cb;
    for(goto_programt::targett ins = instructions.begin();
      ins != instructions.end(); ins++)
    {
      cb.add(ins->code);
    }
    symbol_table.lookup(it->first).value.swap(cb);
  }
}

void add_function_definitions(std::string name,
  goto_functionst &goto_functions, symbol_tablet &symbol_table)
{
  goto_programt gp;
  code_blockt cb = to_code_block(to_code(symbol_table.lookup(name).value));
  for(unsigned int b = 0; b < cb.operands().size(); b++)
  {
    goto_programt::targett ins = gp.add_instruction();
    codet c = to_code(cb.operands()[b]);
    if(ID_assign == c.get_statement())
    {
      ins->make_assignment();
      ins->code = code_assignt(c.operands()[0], c.operands()[1]);
    }
    else if(ID_output == c.get_statement())
    {
      ins->make_other(c);
    }
    else if(ID_label == c.get_statement())
    {
      ins->make_skip();
    }
    else if(ID_function_call == c.get_statement())
    {
      ins->make_function_call(c);
    }
    else
    {
      ins->code = c;
    }
  }
  gp.add_instruction(END_FUNCTION);
  gp.update();
  (*goto_functions.function_map.find(name)).second.body.swap(gp);
}

void set_entry_point(goto_functionst &goto_functions,
  symbol_tablet &symbol_table)
{
  set_function_symbol_value(goto_functions.function_map, symbol_table);
  // message_clientt mct;
  // message_handlert &message_handler = mct.get_message_handler();
  /*)
{
#endif
*/
  int argc;
  const char **argv;
  cbmc_parse_optionst parse_options(argc, argv);
  parse_options.get_message_handler();
  // bmct bmc;
  ansi_c_entry_point(symbol_table, "main", parse_options.get_message_handler());
  goto_functions.function_map.insert(
      std::pair<const dstringt, goto_functionst::goto_functiont >("__CPROVER__start",
        goto_functionst::goto_functiont()));
  add_function_definitions("__CPROVER__start", goto_functions, symbol_table);
  goto_functions.function_map.insert(
      std::pair<const dstringt, goto_functionst::goto_functiont >(
        INITIALIZE_FUNCTION, goto_functionst::goto_functiont()));
  add_function_definitions(INITIALIZE_FUNCTION, goto_functions, symbol_table);
}
