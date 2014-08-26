# Hublot Arabic

Hublot makes Facebook-style datetime-contextual datetimes a cinch for your ActiveRecord objects. 

## Examples

#### Comment created just now:

    الآن

#### Comment created seconds or minutes ago

    منذ ١٠ ثواني
    منذ ٢ دقيقه
  
#### Comment created today

    اليوم، الساعه ٥:٣٠ م
  
#### Comment created yesterday

    الأمس، الساعه ٥:٣٠ م
  
#### Comment created this week

    الأحد، الساعه ٥:٣٠ م
  
#### Comment created last week

    الأحد الماضي، الساعه ٥:٣٠ م
    
## Use

    gem "hublot_ar"
  
Call the pretty method in your views:

    <%= @comment.created_at.pretty %>

## Sources

This gem is forked from brettshollenberger/Hublot. Some localization ideas were extracted from Azzurrio/hublot.