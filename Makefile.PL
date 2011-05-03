use inc::Module::Install;
name 'Aplon-Model-OAuth-Consumer';
all_from 'lib/Aplon/Model/OAuth/Consumer.pm';

requires (
    'Mouse' => 0,
    'Aplon' => 0,
    'OAuth::Lite::Consumer' => 0,
);

tests 't/*.t';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
