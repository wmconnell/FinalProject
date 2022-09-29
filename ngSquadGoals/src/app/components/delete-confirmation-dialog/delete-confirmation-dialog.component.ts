import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Goal } from 'src/app/models/goal';

@Component({
  selector: 'app-delete-confirmation-dialog',
  templateUrl: './delete-confirmation-dialog.component.html',
  styleUrls: ['./delete-confirmation-dialog.component.css']
})
export class DeleteConfirmationDialogComponent implements OnInit {
  delete:string = "";

  constructor(public dialogRef: MatDialogRef<DeleteConfirmationDialogComponent>, @Inject(MAT_DIALOG_DATA) public data: string)  {}

  ngOnInit(): void {
  }

  closeDialog() {
    this.dialogRef.close(this.delete);
  }

}
