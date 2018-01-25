Maid.rules do

  repeat '1d' do
    rule 'Cleanup old files' do

      # clean tmp files
      dir('~/tmp/*').each do |f|
        `trash "#{f}"` if 1.week.since?(modified_at(f))
      end

      # clean old Downloads files
      dir('~/Downloads/*.{csv,doc,docx,html,ics,js,java,ppt,js,pdf,py,txt,rb,xml,xlsx,zip}').each do |download|
        puts download
        `trash "#{download}"` if 3.days.since?(created_at(download))
      end

      # # clean old Downloads files
      # watch '~/Desktop', ignore: /some_directory/ do
      # dir('~/Downloads/*').each do |p|
      #   move() if 3.days.since?(created_at(p))
      # end

      dir('~/screenshots/*').each do |screenshot|
        puts screenshot
        `trash "#{screenshot}"` if 3.days.since?(created_at(screenshot))
      end

      # delete duplicates
      trash(dir('~/Downloads/* (1).*'))
      trash(dir('~/Downloads/* (2).*'))
      trash(dir('~/Downloads/*.1'))

      # clean trash
      `trash-empty 7`

      # update duckdns
      `curl 'https://www.duckdns.org/update/addcn.duckdns.org/55a48eee-47fe-4713-ba53-f300c5f12f06'`

    end
  end

  # watch '~/tmp/testing' do
  #   rule 'Testing' do
  #     dir('~/tmp/testing/*').each do |f|
  #       trash(f)
  #     end
  #   end
  # end

end
