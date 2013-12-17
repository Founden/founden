namespace :qc do
  desc 'Starts a Queue Classic worker'
  task :start do
    path = ENV['QC_PID_PATH']
    if path and !File.exist?(path) and File.write(path, Process.pid)
      puts 'Worker (PID:%d) started...' % Process.pid
    end
    Rake::Task['qc:work'].invoke
  end

  desc 'Stops a Queue Classic worker'
  task :stop do
    path = ENV['QC_PID_PATH']
    if path and File.exist?(path) and pid = File.read(path)
      if Process.kill('TERM', pid.to_i) and File.unlink(path)
        puts 'Worker (PID:%d) stopped...' % pid
      end
    end
  end
end
