import { Image } from './../../models/image';
import { Component, LOCALE_ID, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { Squad } from 'src/app/models/squad';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { GoalService } from 'src/app/services/goal.service';
import { SquadService } from 'src/app/services/squad.service';
import { UserService } from 'src/app/services/user.service';
import { Goal } from 'src/app/models/goal';
import { NgForm } from '@angular/forms';
import { MatTableModule } from '@angular/material/table';
import { animate, state, style, transition, trigger } from '@angular/animations';

@Component({
  selector: 'app-squad',
  templateUrl: './squad.component.html',
  styleUrls: ['./squad.component.css'],
  animations: [
    trigger('detailExpand', [
      state('collapsed', style({height: '0px', minHeight: '0'})),
      state('expanded', style({height: '*'})),
      transition('expanded <=> collapsed', animate('225ms cubic-bezier(0.4, 0.0, 0.2, 1)')),
    ]),
  ]
})
export class SquadComponent implements OnInit {
  squads: Squad[] = []
  loggedIn = new User()
  // newSquad: Squad = new Squad();
  updatedSquad: Squad = new Squad();
  selectedSquad: Squad | null = null;
  selectedMember: User | null = null;
  squadImage: Image = new Image();
  addSquad: boolean = false;
  squadNameUnique: boolean = true;
  editSquad: boolean = false;
  addmember: boolean = false;
  newMember: User = new User;
  userName: string = "";
  goals: Goal[] = [];
  columnsToDisplay = ["name", "leader", "numActiveGoals"];
  columnsToDisplayWithExpand = [...this.columnsToDisplay, 'expand'];
  expandedElement: Squad | null = null;


  constructor(private userService: UserService, private auth: AuthService, private router: Router, private route: ActivatedRoute, private goalService: GoalService, private squadService: SquadService) { }

  ngOnInit(): void {
    this.auth.getLoggedInUser().subscribe(
      {
        next: (user) => {
          this.loggedIn = user;
          console.log(user.username);
        },
        error: (err) => {
          console.error("Unable to retrieve user: " + err);
        }
      }
    );
    this.load()
  }


  load = () => {
    console.log("load called");
    let getTheGoals = this.getGoalsBySquad;
    this.squadService.squadsByUser().subscribe({
      next: (squads) => {
        console.log("INDEX SUCCESSFUL");
        squads.forEach(function(squad) {
          getTheGoals(squad);
        })
        this.squads = squads;
      },
      error: (err) => {
        console.error(err);
      }
    });
  }

  select(id: number) {
    this.squadService.show(id).subscribe({
      next: (squad) => {
        this.selectedSquad = squad;
      },
      error: (err) => {
        console.error(err);
      }
    })
  }

  selectMember(id: number) {
    this.userService.show(id).subscribe({
      next: (user) => {
        this.selectedMember = user;
      },
      error: (err) => {
        console.error(err);

      }
    })
  }

  checkSquadName(form: NgForm) {
    // this.newSquad.users.push(this.loggedIn)
    // console.log(this.loggedIn);
    // console.log(this.loggedIn.id);
    // this.newSquad.leader = this.loggedIn
    // this.newSquad.profilePic = this.squadImage;
    this.squadService.existsByName(form.value.name).subscribe({
      next: (exists) => {
        if (exists) {
          this.squadNameUnique = true;
          let newSquad = {} as Squad;
          newSquad.name = form.value.name;
          newSquad.bio = form.value.bio;
          newSquad.profilePic = this.squadImage;
          this.createSquad(newSquad);
        } else {
          this.squadNameUnique = false;
        }
    }
    });
  }

  createSquad = (squad: Squad) => {
    this.squadService.createSquad(squad).subscribe({
      next: (result) => {

        this.displayTable()
        this.load();
      },
      error: (nojoy) => {
        console.error('Error creating squad');
        console.error(nojoy);
      },
    });
  }

  displayTable() {
    this.addSquad = false
    this.selectedSquad = null;
    this.addmember = false;
    this.editSquad = false;
  }

  addMember(userName: string) {
    this.userService.showUser(userName).subscribe({
      next: (user) => {
        this.newMember = user;
        if (this.selectedSquad) {
          this.selectedSquad!.users.push(this.newMember);
          let squadId: number = this.selectedSquad!.id;
          let memberId: number = this.newMember!.id;
          this.squadService.addMember(squadId, memberId).subscribe({
            next: (squad) => {
              this.newMember = new User();
              this.load();
            },
            error: (err) => {
              console.error(err);
            }
          })
        }
      },
      error: (err) => {
        console.log(err);

      }
    });
  }

  deleteSquad(id: number) {
    console.log(id);

    this.squadService.deleteSquad(id).subscribe({
      next: (squad) => {
        this.displayTable();
        this.load();
      },
      error: (err) => {
        console.error(err);
    }
  })
}

updateSquad(form: NgForm, id:number){
  // let id = this.loggedIn.id;
  console.log("In Update Squad Call! BEFORE HTTP");
  console.log(form.value);
  this.squadService.updateSquad(form.value,id).subscribe({
    next:(squad) =>{
      console.log("In Update Squad HTTP Call!");
      this.displayTable();
      this.load();
  },
  error:(err) =>{
    console.error(err);

      }
    })
  }

  getGoalsBySquad = (squad:Squad): void => {
    this.goalService.getGoalsBySquad(squad.id).subscribe({
      next: (result) => {
        squad.goals = result;
      },
      error: (err) => {
        console.error(err);
      }
    });
  }
}
