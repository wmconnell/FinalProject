import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Squad } from 'src/app/models/squad';

@Component({
  selector: 'app-edit-squad-dialog',
  templateUrl: './edit-squad-dialog.component.html',
  styleUrls: ['./edit-squad-dialog.component.css']
})
export class EditSquadDialogComponent implements OnInit {
  squadId: number | null = null;
  constructor(public dialogRef: MatDialogRef<EditSquadDialogComponent>, @Inject(MAT_DIALOG_DATA) public data: Squad)  {}

  ngOnInit(): void {
   this.squadId = this.data.id;
  }

  myFilter = (d: Date | null): boolean => {
    const day = (d || new Date()).getDay();
    // Prevent Saturday and Sunday from being selected.
    return day !== 0 && day !== 6;
  };

  closeDialog() {
    this.dialogRef.close(this.data);
  }
}
