enum TaskFilterEnum { today, tomorow, week }

extension TaskFilterDescription on TaskFilterEnum {

  String get description {
    switch(this) {
      case TaskFilterEnum.today:
        return "DE HOJE";
        case TaskFilterEnum.tomorow:
          return "DE AMANHÃ";
          case TaskFilterEnum.week:
          return "DA SEMANA";
    }
  }

}