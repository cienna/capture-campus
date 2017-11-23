<template>
  <div class="card" style=" margin: auto; width: 20rem;">
    <ul id="buildings" v-for:"building in buildings" class="list-group list-group-flush">
      {{ building.text }}
    </ul>
  </div>
</template>

<script>
  var buildings = new Vue({
    el: '#'
  })
</script>
