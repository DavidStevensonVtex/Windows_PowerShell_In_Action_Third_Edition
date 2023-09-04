# using assembly System.Windows.Forms
using namespace Wystem.Windows.Forms

$form = [Form] @{ Text = 'My First Form' }
$button = [Button] @{
    Text = 'Push Me!'
    Dock = 'Fill'
}
$button.add_Click{ 
    $form.Close()
}

$form.Controls.Add($button)
$form.ShowDialog()