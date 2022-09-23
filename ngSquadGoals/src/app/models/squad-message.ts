export class SquadMessage {
  id: number = 0;
  messageDate: Date; //dates not initialized
  content: string = '';
  sender: any = null;
  squad: any = null;
  original: any = null;
  replies: any[] = [];

  constructor(
    id: number = 0,
  messageDate: Date,
  content: string = '',
  sender: any = null,
  squad: any = null,
  original: any = null,
  replies: any[] = []
  ) {
  this.id = id;
  this.messageDate = messageDate;
  this.content = content;
  this.sender = sender;
  this.squad = squad;
  this.original = original;
  this.replies = replies;
  }

}
