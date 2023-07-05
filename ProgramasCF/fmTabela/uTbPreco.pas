unit uTbPreco;

interface

   uses cf, uDm, db, ADODb, uProd;

   procedure getTbPcImagens(itens:TdataSet; var tb:TADOTable);


implementation



procedure getTbPcImagens(itens:TdataSet; var tb:TADOTable);
var
   dsI:TDataSet;
begin //
   if (tb.TableName <> '') then
      tb.Close();

   itens.First();
   dm.getTable(tb, dm.getCMD('tB', 'getTbRelImg'));

   Itens.First();
   while (itens.Eof = false) do
   begin
      dsI := uProd.getImagemProduto(itens.FieldByName('is_ref').AsString, false);

      tb.AppendRecord([
         {1}itens.FieldByName('is_ref').AsString,
         {2}itens.FieldByName('codigo').AsString,
         {3}itens.FieldByName('descricao').AsString,
         {4}itens.FieldByName('qt_emb').AsString,
         itens.FieldByName('estoqueAtual').AsString,
         itens.FieldByName('Preco 01').AsString,
         {7}itens.FieldByName('Preco 02').AsString,
         dsI.Fields[0]

      ]);

      dsI.Free;
      itens.Next();
   end;

end;

end.
