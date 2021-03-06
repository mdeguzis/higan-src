namespace phoenix {

struct pComboButton : public pWidget {
  ComboButton& comboButton;

  void append(string text);
  void remove(unsigned selection);
  void reset();
  void setSelection(unsigned selection);
  void setText(unsigned selection, string text);

  pComboButton(ComboButton& comboButton) : pWidget(comboButton), comboButton(comboButton) {}
  void constructor();
  void destructor();
};

}
