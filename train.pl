#!usr/bin/perl 
#use warnings;
#use strict;
use Term::ANSIColor qw(:constants);

sub head
{
printf GREEN;
printf "\t\t\t WELCOME TO INDIAN RAILWAYS \t\n";
printf RESET;
printf BLUE;
for($i=0;$i<75;$i++)
{
print "-";
}
printf "\n";
printf RESET;
}



l1:
system("clear");
head();
printf RED;
print "\n MAIN MENU";
print "\n ---------\n";
print "\n[A] Admin\n[C] Customer\n[E] Exit\n\n-->";
our $type = <STDIN>;
chop($type);
if(grep(/[cC]/,$type))
{
	system("clear");
	custMenu();
	print "\nHello Customer!\n";
	printf RESET;
}
elsif(grep(/[aA]/,$type))
{
	adminLogin();
	adminMenu();
	system("clear");
	head();
	print "\nHello Admin!\n";
	printf RESET;
}
elsif(grep(/[eE]/,$type))
{
	printf RESET;
	printf("Exiting..!!\n");
	exit(0);
}	
	
else
{
	printf RESET;
	print("\nInvalid Input.. Enter Again..!!\n");
	goto l1;
}

#-------------------------------------------------------------------
#------------------------ADMIN LOGIN--------------------------------
#-------------------------------------------------------------------
sub adminLogin{
	my $uname="";
	my $pass="";
	my $cnt=0;
	l21:
	system("clear");
	head();
	printf("\nEnter user name and password correctly to login..");
	print"\n\n\nUSERNAME	:";
	$uname=<STDIN>;
	chop($uname);
	if($uname eq "")
	{
		printf("\nPlease specify Username..!! \n Press any key to continue...");
		printf("\nPress (e) to go to Main Menu..!! ");
		$choice=<>;
		if ( grep(/[eE]/,$choice) )
		{
		   goto l1;
		}
		goto l21;
	}
	l22:
	print"\nPASSWORD	:";
	$pass=<STDIN>;
	chop($pass);
	if($pass eq "")
	{
		printf("\nPlease specify Password..!! \n Press any key to continue...");
		printf("\nPress (e) to go to Main Menu..!! ");
		$choice=<>;
		if ( grep(/[eE]/,$choice) )
		{
		   goto l1;
		}
		goto l22;
	}
	print"\n";
	open(FILE,'login') || die "Cannot open file : $!";
	print"\n";
	while(<FILE>)
	{
		$cnt++;
	}
	close(FILE);
	open(FILE,'login')|| die "Cannot open this file : $!";
	while(<FILE>)
	{
		@inputfrmfile = split(/\s+/,"$_");
		chop($inputfrmfile);
		$concatinated = "$uname $pass";
		if(($uname == $inputfrmfile[0])&&($pass eq $inputfrmfile[1]))
		{
			print"\n";
			close(FILE);
			break; 
		}	
		else
		{
			$cnt = $cnt - 1;
		}
	}
	if($cnt==0)
	{
		print"\n\t\t\tAuthentication Failed";
		print"\n\t\t\tTry Again\n";
		$cnt = 0;
		close(FILE);
		$choice = <STDIN>;
		adminLogin();
	}
}


#-------------------------------------------------------------------
#------------------------ADMIN MENU---------------------------------
#-------------------------------------------------------------------

sub adminMenu()
{
	l4:
	system("clear");
	head();
	print("\n\nEnter your choice\n");
	print("\n\t\t\t1. Insert train details \n");
	print("\t\t\t2. Delete train details \n");
	print("\t\t\t3. List of all trains \n");
	print("\t\t\t4. Search for train \n");
	print("\t\t\t5. View Bookings \n");
	print("\t\t\t6. Cancelled Bookings \n");
	print("\t\t\t7. Reports \n");
	print("\t\t\t8. Exit\n\t\t\t-->");
	$ch = <>;
	chop($ch);
	if($ch == 1)
	{
		insertTrain();
	}
	elsif($ch ==2 )
	{
		deleteTrain();
	}
	elsif($ch == 3)
	{
		allTrains();
	}
	elsif($ch ==4)
	{
		searchTrain();
	}
	elsif($ch == 5)
	{
		viewTickets();
	}
	elsif($ch == 6)
	{
		viewCancel();
	}
	elsif($ch == 7)
	{
		report();
	}	
	elsif($ch == 8)
	{
		$press = <>;
		exit(0);	
	}
	else
	{
		print("\n\nInvalid Choice\n");
		print("\n\t\tPress Enter to Continue\n");
		$press = <>;
		goto l4;
	}					
}	

#-------------------------------------------------------------------
#------------------------------CUSTOMER MENU------------------------
#-------------------------------------------------------------------

sub custMenu()
{
	l3:
	system("clear");
	head();
	print("\n\nEnter your choice\n");
	print("\n\t\t\t1. Reserving a Ticket \n");
	print("\t\t\t2. Cancelling a Ticket \n");
	print("\t\t\t3. View Present Ticket Status \n");
	print("\t\t\t4. Exit\n\t\t\t-->");
	$ch = <>;
	chop($ch);
	if($ch == 1)
	{
		reserveTicket();
	}
	elsif($ch ==2 )
	{
		cancelTicket();
	}
	elsif($ch == 3)
	{
		statusTicket();
	}
	elsif($ch == 4)
	{
		$press = <>;
		exit(0);	
	}
	else
	{
		print("\n\nInvalid Choice\n");
		print("\n\t\tPress Enter to Continue\n");
		$press = <>;
		goto l3;
	}
}

#-------------------------------------------------------------------
#-----------------------------RESERVE TICKET------------------------
#-------------------------------------------------------------------

sub reserveTicket()
{
#train no.
#name
#age
#select class= sleeper/ac -> pending / confirmed

l23:
	system("clear");
	head();
	print("\n\nEnter the Train Number(4 digits):");
	$trainno = <STDIN>;
	chop($trainno);
	if(!(grep(/[0-9][0-9][0-9][0-9]/,$trainno)))
	{
		print("\n\nInvalid train number..!!");
		print("\nPress Enter to Continue..!!");
		$press = <STDIN>;
		goto l5;
	}	open(TRAINDETAILS,"traindetails");	
	$cnt = 0;
	while(<TRAINDETAILS>)
	{
		@vals = split(/\s+/,"$_");
		if($vals[0] == $trainno)
		{
			$cnt =1;
		}
	}
	if($cnt == 1)
	{
		print("\nCorrect Train number..!!\n");
		goto l23;
	}
	else
	{
		printf("\nEnter Correct train number:");
		print("\nPress enter to continue");
		printf("\nPress (e) to go to Customer Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l3;
		}
		goto l23;
	}
	close(TRAINDETAILS);
l24:
	print("\nEnter your Name		:");
	$name = <STDIN>;
	chop($name);
	if(!(grep(/[a-zA-Z]/,$name)))
	{
		print("\n\nTrain name can have only alphabets ..! ");
		print("\nPress enter to continue.!!!");
		printf("\nPress (e) to go to Customer Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l3;
		}
		goto l24;
	}
l25:
	print("\nEnter your Age		:");
	$name = <STDIN>;
	chop($age);
	if(!(grep(/[0-9]/,$age)))
	{
		print("\n\nAge can have only digits ..! ");
		print("\nPress enter to continue.!!!");
		printf("\nPress (e) to go to Customer Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l3;
		}
		goto l25;
	}


#-------------------------------------------------------------------
#------------------------INSERT NEW TRAINS--------------------------
#-------------------------------------------------------------------

sub insertTrain()
{
l5:
	system("clear");
	head();
	print("\n\nEnter the Train Number(4 digits):");
	$trainno = <STDIN>;
	chop($trainno);
	if(!(grep(/[0-9][0-9][0-9][0-9]/,$trainno)))
	{
		print("\n\nInvalid train number..!!");
		print("\nPress Enter to Continue..!!");
		$press = <STDIN>;
		goto l5;
	}	open(TRAINDETAILS,"traindetails");	
	$cnt = 0;
	while(<TRAINDETAILS>)
	{
		@vals = split(/\s+/,"$_");
		if($vals[0] == $trainno)
		{
			$cnt =1;
		}
	}
	if($cnt == 1)
	{
		print("\nTrain number already available..!!\n");
		print("\nPress enter to continue");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eB]/,$press) )
		{
		   goto l4;
		}
		close(TRAINDETAILS);
		goto l5;
	}
	close(TRAINDETAILS);
l6:
	print("\nEnter the Train Name		:");
	$tname = <STDIN>;
	chop($tname);
	if(!(grep(/[a-zA-Z]/,$tname)))
	{
		print("\n\nTrain name can have only alphabets ..! ");
		print("\nPress enter to continue.!!!");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l4;
		}
		goto l6;
	}
l7:
	print("\nNO. OF A/C FIRST CLASS SEATS	:");
	$ac1 = <STDIN>;
	chop($ac1);
	if($ac1 eq "0")
	{
	$cost1 = "0";
	$costac1 = "0";
	}
	if(!(grep(/[^a-zA-Z]/,$ac1)))
	{	
		print("\n\nEnter a valid integer..!! ");	
		print("\nPress Enter to Continue...");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l4;
		}
		goto l7;
	}
l8:
	print("\nNO. OF A/C SECOND CLASS SEATS	:");
	$ac2 = <STDIN>;
	chop($ac2);
	if($ac2 eq "0")
	{
	$cost2 = "0";
	$costac2 = "0";
	}
	if(!(grep(/[^a-zA-Z]/,$ac2)))
	{
		
		print("\n\nEnter a valid integer..!! ");	
		print("\nPress Enter to Continue...");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l4;
		}
		goto l8;
	}
	
l9:
	print("\nNO. OF A/C THIRD CLASS SEATS	:");
	$ac3 = <STDIN>;
	chop($ac3);
	if($ac3 eq "0")
	{
	$cost3 = "0";
	$costac3 = "0";
	}
	if(!(grep(/[^a-zA-Z]/,$ac3)))
	{
		print("\n\nEnter a valid integer..!! ");	
		print("\nPress Enter to Continue...");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l4;
		}
		goto l9;
	}
	
l10:
	print("\nNO. OF SLEEPER CLASS SEATS	:");
	$sleeper = <STDIN>;
	chop($sleeper);
	if(!(grep(/[^a-zA-Z]/,$sleeper)))
	{
		print("\n\nEnter a valid integer..!! ");	
		print("\nPress Enter to Continue...");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l4;
		}
		goto l10;
	}
l11:
	if($cost1 ne "0")
	{
	print("\nCOST OF A/C FIRST CLASS SEAT	:");
	$costac1 = <STDIN>;
	chop($costac1);
	if(!(grep(/[^a-zA-Z]/,$costac1)))
	{
		print("\n\nEnter a valid integer ");	
		print("\nPress Enter to Continue");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l4;
		}
		goto l11;
	}
	}

l12:
	if($cost2 ne "0")
	{
	print("\nCOST OF A/C SECOND CLASS SEAT	:");
	$costac2 = <STDIN>;
	chop($costac2);
	if(!(grep(/[^a-zA-Z]/,$costac2)))
	{
		print("\n\nEnter a valid integer ");	
		print("\nPress Enter to Continue");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l4;
		}
		goto l12;
	}
	}

l13:
	if($cost3 ne "0")
	{
	print("\nCOST OF A/C THIRD CLASS SEAT	:");
	$costac3 = <STDIN>;
	chop($costac3);
	if(!(grep(/[^a-zA-Z]/,$costac3)))
	{
		print("\n\nEnter a valid integer ");	
		print("\nPress Enter to Continue");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l4;
		}
		goto l13;
	}
	}

l14:
	print("\nCOST OF SLEEPER CLASS SEAT	:");
	$costsleep = <STDIN>;
	chop($costsleep);
	if(!(grep(/[^a-zA-Z]/,$costsleep)))
	{
		print("\n\nEnter a valid integer ");	
		print("\nPress Enter to Continue");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l4;
		}
		goto l14;
	}
l15:
	print("\nSTARTING STATION       		:");
	$source = <STDIN>;
	chop($source);
	if(!(grep(/[a-zA-Z]/,$source)))
	{
		print("\n\nStation name can have only alphabets ..! ");
		print("\nPress enter to continue.!!!");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l4;
		}
		goto l15;
	}
l16:
	print("\nDESTINATION STATION    		:");
	$destination = <STDIN>;
	chop($destination);
	if(!(grep(/[a-zA-Z]/,$destination)))
	{
		print("\n\nStation name can have only alphabets ..! ");
		print("\nPress enter to continue.!!!");
		printf("\nPress (e) to go to Admin Menu..!! ");
		$press=<STDIN>;
		if ( grep(/[eE]/,$press) )
		{
		   goto l4;
		}
		goto l16;
	}
	open(TRAINDETAILS,'>>traindetails');
	print TRAINDETAILS ("\n$trainno:$tname:$ac1:$ac2:$ac3:$sleeper:$costac1:$costac2:$costac3:$costsleep:$source:$destination");
	printf("\nTrain details inserted successfully..!!");
	print("\nPress Enter to go to Admin Menu...");
	close(TRAINDETAILS);
	$press = <STDIN>;
	adminMenu();
}

