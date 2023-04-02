REQUIRED_KEYS = %w[byr iyr eyr hgt hcl ecl pid]

def passports(batch)
  batch.split("\n\n")
end

def passport_fields(passport)
  passport.split
end

def keys(fields)
  fields.map { |field| field.split(':').first }
end

def valid_passport?(passport, required)
  (keys(passport_fields(passport)) & required).length >= required.length
end

def valid_passports_count(batch, req)
  passports(batch).reduce(0) { |acc, pass| valid_passport?(pass, req) ? acc + 1 : acc }
end

def values(fields)
  fields.reduce({}) do |acc, field|
    key, value = field.split(':')
    acc[key] = value
    acc
  end
end

def valid_byr?(val)
  year = Integer(val)
  year >= 1920 && year <= 2002
rescue ArgumentError
  false
end

def valid_iyr?(val)
  year = Integer(val)
  year >= 2010 && year <= 2020
rescue ArgumentError
  false
end

def valid_eyr?(val)
  year = Integer(val)
  year >= 2020 && year <= 2030
rescue ArgumentError
  false
end

def valid_hgt(val)
  val_i = val.to_i
  if val.end_with?('cm')
    val_i >= 150 && val_i <= 193
  else
    val_i >= 59 && val_i <= 76
  end
end

def valid_hcl(val)
  (val =~ /^\#[a-z0-9]{6}$/) != nil
end

def valid_ecl(val)
  %w[amb blu brn gry grn hzl oth].include?(val)
end

def valid_pid(val)
  (val =~ /^[0-9]{9}$/) != nil
end

def valid_passport_v2?(passport, required)
  fields = passport_fields(passport)
  values = values(fields)
  ((keys(fields) & required).length >= required.length) && valid_byr?(values['byr']) &&
    valid_iyr?(values['iyr']) && valid_eyr?(values['eyr']) && valid_hgt(values['hgt']) &&
    valid_hcl(values['hcl']) && valid_ecl(values['ecl']) && valid_pid(values['pid'])
end

def valid_passports_count_v2(batch, req)
  passports(batch).reduce(0) { |acc, pass| valid_passport_v2?(pass, req) ? acc + 1 : acc }
end

test_batch = """ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
"""

pp = passports(test_batch)

p valid_passport_v2?(pp[0], REQUIRED_KEYS)
p valid_passports_count_v2(test_batch, REQUIRED_KEYS)

batch = File.read('input.txt')
p valid_passports_count_v2(batch, REQUIRED_KEYS)
