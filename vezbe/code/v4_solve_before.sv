class bez_ogranicenja;
   rand bit ctrl;
   rand bit [31:0] data;
endclass

class implikacija;
   rand bit ctrl;
   rand bit [31:0] data;
   constraint c_impl {ctrl -> (data == 0);}
endclass

class sa_redosledom;
   rand bit ctrl;
   rand bit [31:0] data;
   constraint c_impl {ctrl -> (data == 0);}
   constraint c_red {solve ctrl before data;}
endclass
