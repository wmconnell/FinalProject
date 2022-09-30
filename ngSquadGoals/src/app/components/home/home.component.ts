import { UserService } from 'src/app/services/user.service';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  constructor(private auth: AuthService, private userService: UserService) { }

  loggedInUser: User = new User();
  isLoggedIn: boolean = false;

    ngOnInit(): void {
      this.load();
    }

    load = (): void => {
      this.auth.getLoggedInUser().subscribe(
        {
        next: (user) => {
          console.log(user);
          this.loggedInUser = user;
          this.isLoggedIn = true;
          this.userService.show(user.id).subscribe({
            next: (result) => {
              console.log(result);
              this.loggedInUser.profilePic = result.profilePic;
            },
            error: (err) => {
              console.error("Unable to retrieve user: " + err);
            }
          })
        },
        error: (err) => {
          console.error("Unable to retrieve user: " + err);
        }
      }
      );
    }

    logout(){
      this.isLoggedIn = false;
      this.auth.logout()
    }
}
