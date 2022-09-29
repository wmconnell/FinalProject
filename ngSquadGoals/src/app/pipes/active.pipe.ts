import { Squad } from 'src/app/models/squad';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'active'
})
export class ActivePipe implements PipeTransform {


  transform(squads: Squad[], status: boolean = true): Squad[] {
    if(status === false){
      return squads;
    }
    const result:Squad[] = [];
    if (squads !== null && squads !== undefined && squads.length > 0) {
      for(let squad of squads){
      if(squad.active === status){
        result.push(squad);
      }
    }
  }
    return result;
  }

}
