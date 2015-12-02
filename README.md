project: Money Manager

-	Money Manager is a Web Applikation, which helps its users to get an 		overview over their incomings and outgoings. 

- 	The database contains following tables:

	user 		(
				UID: BIGINT
			)
	UID = PK
	
	pocket 		(
				PID: BIGINT,
				pocket_name: varchar,
				UID: BIGINT
			)
	PID = PK
	UID = FK

	calendar	(
				TID: INT,
				period: date,
				sum_income: double,
				sum_outgoing: double,
				balance: double,
				PID: INT,
				UID: BIGINT
			)
	TID = PK
	PID, UID = FK

	category	(
				CID: INT,
				category_name: varchar,
				way: boolean,
				UID: BIGINT
			)
	CID = PK
	UID = FK

	income		(
				IID: INT,
				note: varchar,
				note_date: date,
				sum: double,
				CID: INT,
				PID: INT,
				UID: BIGINT
			)
	IID = PK
	CID, PID, UID = FK

	outgoing	(
				OID: INT,
				note: varchar,
				note_date: date,
				sum: double,
				CID: INT,
				PID: INT,
				UID: BIGINT
			)
	OID = PK
	UID, CID, PID = FK

	example for a create statement:

		CREATE TABLE income
		(
			IID INT NOT NULL AUTO_INCREMENT UNIQUE,
			note varchar(50),
			note_date date,
			sum double(10,2),
			CID INT NOT NULL,
			PID INT NOT NULL,
			UID BIGINT NOT NULL,
			primary key (IID),
			foreign key (CID) REFERENCES category(CID),
			foreign key (PID) REFERENCES pocket(PID),
			foreign key (UID) REFERENCES user(UID)
		);

-	all functions are released into the functions.php

	some examples:
	
	- function for single incomes with all parameters:
		
		function get_single_incomes($category_name, $chosenpocket, $uid){
			global $dbh;
			$incomes = $dbh->prepare( "	SELECT i.note, i.note_date, i.sum 
							FROM income as i, pocket as p, category as c
							WHERE i.PID = p.PID
							AND i.CID = c.CID
							AND p.pocket_name = ?
							AND c.category_name = ?
							AND p.UID = ?;");

			$incomes->bindParam(1, $chosenpocket, PDO::PARAM_STR);
			$incomes->bindParam(2, $category_name, PDO::PARAM_STR);
			$incomes->bindParam(3, $uid, PDO::PARAM_INT);


			$incomes->execute();

			return $incomes->fetchAll();
		}

		use function:
			<?php $incomes = get_single_incomes($cati->Category, $chosenpocket, $uid);  ?>
				<?php foreach( $incomes as $income ) : ?>
					<li>
						<?php echo $income->note_date ?><span class="srow"><?php echo $income->note ?></span>
						<?php echo '€&nbsp;&nbsp;&nbsp;&nbsp;'.$income->sum ?>	
					</li>
				<?php endforeach; ?>


	- function for updating calendar table after adding outgoings or incomes

		function update($pocket, $uid){
			global $dbh;
		
			$statement = $dbh->prepare("SELECT sum(o.sum) as Sum
										FROM outgoing as o
										WHERE o.PID = ?
										AND o.UID = ?;");
			$statement->bindParam(1, $pocket, PDO::PARAM_INT);
			$statement->bindParam(2, $uid, PDO::PARAM_INT);
			$statement->execute();
			$sum_outgoing = $statement->fetch()->Sum;


			$statement = $dbh->prepare("SELECT sum(i.sum) as Sum
										FROM income as i
										WHERE i.PID = ?
										AND i.UID = ?;");
			$statement->bindParam(1, $pocket, PDO::PARAM_INT);
			$statement->bindParam(2, $uid, PDO::PARAM_INT);
			$statement->execute();
			$sum_income = $statement->fetch()->Sum;


			if($sum_outgoing == NULL) $sum_outgoing = 0;
			if($sum_income == NULL) $sum_income = 0;
			
			$actual_balance = $sum_income - $sum_outgoing;


			$update = $dbh->prepare("UPDATE calendar
										SET sum_income = ?, sum_outgoing = ?, balance = ?
										WHERE PID = ?
										AND UID = ?;");
			$update->bindParam(1, $sum_income, PDO::PARAM_STR);
			$update->bindParam(2, $sum_outgoing, PDO::PARAM_STR);
			$update->bindParam(3, $actual_balance, PDO::PARAM_STR);
			$update->bindParam(4, $pocket, PDO::PARAM_INT);
			$update->bindParam(5, $uid, PDO::PARAM_INT);

			$update->execute();
		}

		use function:
			<?php update($pocket, $uid); ?>


translating into rails:

-----------------------------------------------------------------------------------------------------------------------------------

	creating models with "rails generate scaffold ..."
	
	- user name:string
	- pocket name:string user:references
	- calendar period:date sum_income:decimal sum_outgoing:decimal balance:decimal pocket:references user:references
	- category name:string way:boolean user:references 
	- income note:string date:date sum:decimal category:references pocket:references user:references
	- outgoing note:string date:date sum:decimal category:references pocket:references user:references

-----------------------------------------------------------------------------------------------------------------------------------

	migrated models with "rake db:migrate"
	started rails server with "rails server"

-----------------------------------------------------------------------------------------------------------------------------------

	added some data in console & some in browser:

	- Users
		User.create(:name => "Eveline")
		User.create(:name => "Hannes")
		User.create(:name => "Magdalena")
		User.create(:name => "Nadja")
		User.create(:name => "Alexander")

	- Pockets
		Pocket.create(:name => "Cash", :user_id => 1)
		Pocket.create(:name => "Card", :user_id => 1)
		Pocket.create(:name => "Cash", :user_id => 2)
		Pocket.create(:name => "Card", :user_id => 2)
		Pocket.create(:name => "Cash", :user_id => 3)
		Pocket.create(:name => "Piggybank", :user_id => 3)
		Pocket.create(:name => "Cash", :user_id => 4)
		Pocket.create(:name => "Card", :user_id => 4)
		Pocket.create(:name => "Cash", :user_id => 5)
		Pocket.create(:name => "Piggybank", :user_id => 5)

	- Calendars
		Calendar.create(:period => "2015-11-07", :sum_income => 500.00, :sum_outgoing => 300.00, :balance => 200.00, :pocket_id => 5, :user_id => 1)

	- Categories
		Category.create(:name => "Gehalt", :way => '0', :user_id => 1)

	- Incomes
		Income.create(:note => "Taschengeld", :date => "2015-11-01", :sum => 250, :category_id => 3, :pocket_id => 14, :user_id => 5)

	- Outgoings
		Outgoing.create(:note => "Kino", :date => "2015-11-06", :sum => 17.50, :category_id => 1, :pocket_id => 5, :user_id => 1)

-----------------------------------------------------------------------------------------------------------------------------------

	adding validations to models with:
		validates_presence_of

-----------------------------------------------------------------------------------------------------------------------------------

	testing some queries

	- get categories from user 1
		rails console input:
			Category.where(user_id: 1)
		output:
			Category Load (0.2ms)
			SELECT "categories".* FROM "categories"
			WHERE "categories"."user_id" = ?  [["user_id", 1]]

			=> #<ActiveRecord::Relation
			[#<Category id: 1, name: "Kino", way: "1", user_id: 1, created_at: "2015-11-07 14:38:21", updated_at: "2015-11-07 14:38:21">, 
			#<Category id: 2, name: "Gehalt", way: "0", user_id: 1, created_at: "2015-11-07 14:38:39", updated_at: "2015-11-07 14:38:39">]>

	- get pocket names from user 3
		rails console input:
			Pocket.select(:name).where(user_id:3)
		output:
			Pocket Load (0.2ms)
			SELECT "pockets"."name" FROM "pockets"
			WHERE "pockets"."user_id" = ?  [["user_id", 3]]

			=> #<ActiveRecord::Relation
			[#<Pocket id: nil, name: "Cash">, 
			#<Pocket id: nil, name: "Piggybank">]>
		-> id is nil because of select statement

	- get all incomes from user 5
		rails console input:
			Income.select(:note, :date, :sum, :id).where(user_id:5)
		output:
			Income Load (0.1ms)
			SELECT "incomes"."note", "incomes"."date", "incomes"."sum", "incomes"."id"
			FROM "incomes"
			WHERE "incomes"."user_id" = ?  [["user_id", 5]]

			=> #<ActiveRecord::Relation
			[#<Income id: 1, note: "Taschengeld", date: "2015-11-01", 
			sum: #<BigDecimal:7f5b88fd09e0,'0.25E3',9(27)>>]>

			
			
	conclusion:
		most of the queries worked, but the output at some queries is weird
		like at example 3 "get all incomes from user 5", where sum is not a
		simple decimal but #<BigDecimal:7f5b88fd09e0,'0.25E3',9(27),
		or similar at example 2 "get pocket names from user 3",
		where id in output is nil because the query is just
		looking for the name of the pocket)
		but if one can handle the output -
		every query is possible (maybe even easier than with php :D) 






