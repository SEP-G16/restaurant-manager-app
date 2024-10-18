enum MenuItemStatus{
  InStock, OutOfStock;

  static MenuItemStatus fromString(String status){
    if(status == 'InStock'){
      return MenuItemStatus.InStock;
    }else{
      return MenuItemStatus.OutOfStock;
    }
  }
}

extension MenuItemStatusExtension on MenuItemStatus{
  String get asString{
    switch(this){
      case MenuItemStatus.InStock:
        return 'InStock';
      case MenuItemStatus.OutOfStock:
        return 'OutOfStock';
    }
  }
}

