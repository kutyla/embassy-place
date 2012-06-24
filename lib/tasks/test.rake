task :test do
  Rake::Task["cucumber"].invoke
end
