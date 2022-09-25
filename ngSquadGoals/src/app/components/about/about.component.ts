import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-about',
  templateUrl: './about.component.html',
  styleUrls: ['./about.component.css']
})
export class AboutComponent implements OnInit {
loggedIn: User = new User();

constructor(private userService: UserService,private auth: AuthService,private router: Router, private route: ActivatedRoute) { }


ngOnInit(): void {
  this.load();
}

load = (): void => {
  this.auth.getLoggedInUser().subscribe(
    {
    next: (user) => {
      this.loggedIn = user;
      console.log("Successfully retrieved user id " + user.id);
    },
    error: (err) => {
      console.error("Unable to retrieve user: " + err);
    }
  }
  );
}

}
