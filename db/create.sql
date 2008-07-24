create table sites(
    id integer not null primary key,
    title text not null unique,
    url text not null unique,
    updated_at datetime not null,
    created_at datetime not null
);

create table douga(
    id integer not null primary key,
    url text not null unique,
    site text not null,
    referer text not null,
    downloaded integer not null,
    updated_at datetime not null,
    created_at datetime not null
);
