function merg = mergeHeaderAndMatrix(a, b, data, id, gender, genus, species, subspecies, zoom)
data_a_b = data(1:a, 1:b);
id_a = id(1,1:a)';
id_a = num2cell(id_a);
genus_a = genus(1, 1:a)';
gender_a = gender(1, 1:a)';
species_a = species(1, 1:a)';
subspecies_a = subspecies(1, 1:a)';
zoom_a = num2cell(zoom(1, 1:a)');

header = [id_a genus_a gender_a species_a subspecies_a zoom_a];

cellData = num2cell(data_a_b);

merg = [header cellData];

end