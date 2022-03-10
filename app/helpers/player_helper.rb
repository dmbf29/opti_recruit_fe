module PlayerHelper
  def value_eur_display(num)
    return '-' unless num

    if num.digits.length >= 7
      "€#{num&.fdiv(1000000)&.round(2)}M"
    elsif num.digits.length >= 4
      "€#{num&.fdiv(1000)&.round(2)}K"
    else
      "€#{num}"
    end
  end
end
