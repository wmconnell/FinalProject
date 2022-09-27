import { Image } from './../../models/image';
import { Component, LOCALE_ID, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { Squad } from 'src/app/models/squad';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { GoalService } from 'src/app/services/goal.service';
import { SquadService } from 'src/app/services/squad.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-squad',
  templateUrl: './squad.component.html',
  styleUrls: ['./squad.component.css']
})
export class SquadComponent implements OnInit {
  squads: Squad[] = []
  loggedIn = new User()
  newSquad: Squad = new Squad();
  updatedSquad: Squad = new Squad();
  selectedSquad: Squad| null = null;
  squadImage: Image = new Image();
  addSquad: boolean = false;
  editSquad: boolean = false;
  addmember: boolean = false;
  newMember: User = new User;
  userName: string = "";

  constructor(private userService: UserService, private auth: AuthService, private router: Router, private route: ActivatedRoute, private goalService: GoalService, private squadService: SquadService) { }

  ngOnInit(): void {
    this.auth.getLoggedInUser().subscribe(
      {
      next: (user) => {
        this.loggedIn = user;
        console.log(user.username);
        // this.squads = user.squads;

        console.log(this.squads.length);


        // console.log("Successfully retrieved user id " + user.id);
      },
      error: (err) => {
        console.error("Unable to retrieve user: " + err);
      }
    }
    );
    this.load()
  }


  load() {
    console.log("load called");

    this.squadService.index().subscribe({
      next: (squad) => {
        this.squads = squad;
        // console.log(this.squads.length);
      },
      error: (err) => {
        console.error(err);

      }
    });
  }
  select(id:number){
      this.squadService.show(id).subscribe({
        next: (squad) =>{
          this.selectedSquad = squad;
        },
        error:(err) =>{
          console.error(err);

        }
      })
  }

  createSquad(){
    // this.newSquad.users.push(this.loggedIn)
    console.log(this.loggedIn);
    console.log(this.loggedIn.id);

    // this.newSquad.leader = this.loggedIn
    // this.newSquad.profilePic = this.squadImage;

    this.squadService.createSquad(this.newSquad).subscribe({
      next: (result) => {

        this.newSquad = new Squad();
      this.load();
    },
    error: (nojoy) => {
      console.error('Error creating squad');
      console.error(nojoy);
    },
  });
}
displayTable(){
  this.addSquad = false
  this.selectedSquad = null;
  this.addmember =false;
  this.editSquad =false;
}
addMember(userName: string){
  this.userService.showUser(userName).subscribe({
      next: (user) =>{
        this.newMember = user;
        console.log(user);

        if(this.selectedSquad){
          console.log(this.newMember);

          this.selectedSquad!.users.push(this.newMember);
          let squadId:number = this.selectedSquad!.id;
          let memberId:number = this.newMember!.id;
          console.log(this.selectedSquad);

          this.squadService.addMember(squadId,memberId).subscribe({
            next: (squad) =>{
              this.newMember = new User();
              this.selectedSquad = squad;
              this.load();

            },
            error: (err) =>{
              console.error(err);

            }


          })

        }
        // this.displayTable();
      },
      error: (err) =>{
        console.log(err);

      }
    });

}
deleteSquad(id: number){
  console.log(id);

  this.squadService.deleteSquad(id).subscribe({
    next: (squad)=>{
      this.displayTable();
      this.load();

    },
    error:(err)=>{
      console.error(err);

    }
  })
}
updateSquad(squad: Squad){
  let id = squad.id;
  this.squadService.updateSquad(squad,id).subscribe({
    next:(squad) =>{

      this.updatedSquad = new Squad();
      this.displayTable();
      this.load();
  },
  error:(err) =>{
    console.error(err);

  }
  })
}
}
