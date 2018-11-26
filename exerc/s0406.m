clear
% One variant:
people=table([11.5 8 13]',{'blue','orange','flashy green'}',...
  'RowNames',{'Harald','Ernie','Bert'},...
  'VariableNames',{'shoe_size','favourite_color'})

% Oh, we forgot the other Ernie. Let's add him:
people(end+1,:)={{'black'},10}
% Oops, an error: we confused column order. Note:
% this is a 'built-in' data consistency check of
% tables. This is better:
people(end+1,:)={10,{'black'}}
% We should update the row name
people.Properties.RowNames{4}='Ernie';
% Ouch! Doesn't work because we have a row labeled
% 'Ernie' already. Violà another instance of data
% checking. So, either we have to rename Ernie...
people.Properties.RowNames{4}='Ernie2'
% ...which in this form is certainly
% unsatisfactory. We could add last names.
% However, in large data bases individuals with
% identical names are certain to occur. So, when
% dealing with data sets in which the individual
% rows don't have unique identifiers we had better
% rethink the layout of our table. It's probably
% best to make the names a variable, too:
people=table({'Harald','Ernie','Bert'}',...
  [11.5 8 13]',{'blue','orange','flashy green'}',...
  'VariableNames',{'name','shoe_size','favourite_color'})
% Now, Ernie the Second will blend in smugly (at
% least without an error; whether we would need
% unique IDs depends on the application)
people(end+1,:)={{'Ernie'},10,{'black'}}

% Performing computations on the entries in the
% table (just one for exemplary illustration):
[people.shoe_size]
% individuals with shoe size<12:
tmp=[people.shoe_size]<12
people.name(tmp)
