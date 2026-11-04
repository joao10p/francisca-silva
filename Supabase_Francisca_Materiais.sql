-- Executar no SQL Editor do projeto francisca-silva, uma única vez.
-- Anexos privados de módulos; limite individual de 20 MB.
insert into storage.buckets (id,name,public,file_size_limit)
values ('francisca-materiais','francisca-materiais',false,20971520)
on conflict (id) do update set public=false,file_size_limit=20971520;

create policy "Francisca materiais: ler apenas os próprios"
on storage.objects for select to authenticated
using (bucket_id='francisca-materiais' and (storage.foldername(name))[1]=(select auth.uid()::text));
create policy "Francisca materiais: enviar apenas os próprios"
on storage.objects for insert to authenticated
with check (bucket_id='francisca-materiais' and (storage.foldername(name))[1]=(select auth.uid()::text));
create policy "Francisca materiais: apagar apenas os próprios"
on storage.objects for delete to authenticated
using (bucket_id='francisca-materiais' and (storage.foldername(name))[1]=(select auth.uid()::text));
