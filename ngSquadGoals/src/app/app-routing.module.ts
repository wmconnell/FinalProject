import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AboutComponent } from './components/about/about.component';
import { GoalComponent } from './components/goal/goal.component';
import { HomeComponent } from './components/home/home.component';
import { LoginComponent } from './components/login/login.component';
import { MygoalsComponent } from './components/mygoals/mygoals.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { PublicsquadComponent } from './components/publicsquad/publicsquad.component';
import { RegisterComponent } from './components/register/register.component';
import { SquadComponent } from './components/squad/squad.component';
import { UserComponent } from './components/user/user.component';

const routes: Routes = [
{ path: '', pathMatch: 'full', redirectTo: 'home' },
{ path: 'home', component: HomeComponent },
{ path: 'register', component: RegisterComponent },
{ path: 'login', component: LoginComponent },
{ path: 'about', component: AboutComponent },
{ path: 'user', component: UserComponent },
{ path: 'goals', component: GoalComponent },
{ path: 'mygoals', component: MygoalsComponent },
{ path: 'mysquads', component: SquadComponent },
{ path: 'squads', component: PublicsquadComponent },
{ path: 'user/:username', component: UserComponent },
{ path: '**', component: NotFoundComponent}
]

@NgModule({
  imports: [RouterModule.forRoot(routes,{useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
