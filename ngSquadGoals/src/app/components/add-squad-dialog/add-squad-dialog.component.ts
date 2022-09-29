import { SquadService } from 'src/app/services/squad.service';
import { Component, OnInit } from '@angular/core';
import { Squad } from 'src/app/models/squad';
import { Image } from './../../models/image';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-add-squad-dialog',
  templateUrl: './add-squad-dialog.component.html',
  styleUrls: ['./add-squad-dialog.component.css']
})
export class AddSquadDialogComponent implements OnInit {
  squadNameUnique: boolean = true;
  squadImage: Image = new Image();
  constructor(private squadService: SquadService,
    public dialogRef: MatDialogRef<AddSquadDialogComponent>) { }

  ngOnInit(): void {

  }

  checkSquadNameUnique(event: Event) {
    const squadName = (event.target as HTMLInputElement).value;
    let tempSquad = {} as Squad;
    tempSquad.name = squadName;
    this.squadService.existsByName(tempSquad).subscribe({
      next: (exists) => {
        if (!exists) {
          this.squadNameUnique = true;
        } else {
          this.squadNameUnique = false;
        }
      }
    });
  }
}
