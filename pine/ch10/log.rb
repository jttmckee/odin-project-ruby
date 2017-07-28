def log description, &block
    puts ("  " * $counter) + "Block #{description} has started"
    $counter = $counter + 1
    returnValue = block.call
    $counter = $counter - 1
    puts ("  " * $counter) + "Block #{description} has finished with return value #{returnValue}"
  end
$counter = 0
log "Outer block" do
  log "Inner block" do
    log "completely inner block" do
      0
    end
      1
  end
   10
end
