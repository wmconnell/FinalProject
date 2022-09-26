import { GoalService } from './../../services/goal.service';
import { User } from 'src/app/models/user';
import { UserService } from './../../services/user.service';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { ActivatedRoute, Router } from '@angular/router';
import { Goal } from 'src/app/models/goal';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent implements OnInit {
users: User[] =[]
loggedIn: User = new User();
username: string | string = "admin";
goals: Goal[] = []
  constructor(private userService: UserService,private auth: AuthService,private router: Router, private route: ActivatedRoute, private goalService: GoalService) { }

  ngOnInit(): void {


    let idStr = this.route.snapshot.paramMap.get('username');
    // let idStr = '4'
    console.log(idStr);

    if(idStr){

      // got a todo ID, get and display todo
      // let userId = Number.parseInt(idStr);
      //   if(!isNaN(userId)){
        this.userService.showUser(idStr).subscribe({

          next: (user) =>{
            console.log(user);

            this.loggedIn =user;
            console.log(this.loggedIn);

            this.load();
          },
          error: (err) =>{
            console.error('Error retriveing User:');
            console.error(err);
            this.router.navigateByUrl('noSuchUser')
          }
        })
        }
        else{
          console.error('Invalid User Id: ' + idStr)
        }
    // }

  }

  setUser(username: string){
    this.auth.getUser(username).subscribe({
      next:(user) =>{
        this.loggedIn =user;
      }
    });
  }
load(){
  if(this.loggedIn){
   this.goalService.index().subscribe({
     next: (goal) =>{
       this.goals = goal
     },
     error: (err) =>{
       console.log(err);

     }
   })


  }
  // this.userService.show(this.loggedIn.id).subscribe({
  //   next: (user) =>{
  //     this.loggedIn =user
  //   },
  //   error: (problem) =>{
  //     console.error("error loading users")
  //     console.error(problem)
  //   }


  // })
}

}
