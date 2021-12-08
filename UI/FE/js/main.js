function createAlert(...data) {
  let container = document.getElementsByClassName('container')[0];
  for(let i = 0; i < data.length; ++i) {
    container.insertAdjacentHTML('afterbegin', `<div class="alert alert-primary" role="alert">
    ${data[i]}
    </div>`);
  }
}

function layThongTin(isFix) {
  let container = document.getElementsByClassName('container')[0];
  container.innerHTML = '';
  container.insertAdjacentHTML('afterbegin', `
  <table class="table">
    <thead>
      <tr>
        <th scope="col">Mã Tài Xế</th>
        <th scope="col"></th>
      </tr>
    </thead>
    <tbody>
    </tbody>
  </table>`);
  let tbody = document.querySelector("body > div.container > table > tbody");
  fetch("http://127.0.0.1:8000/lay-ma-tai-xe/")
    .then((response) => response.json())
    .then((data) => {
      tbody.innerHTML = "";
      for (let i = 0; i < data.res.length; ++i) {
        let row = data.res[i];
        let tr = document.createElement('tr');
        tr.innerHTML = `<td>${row.MaTX}</td>`;
        let td = document.createElement('td');
        let btn = document.createElement('button');
        btn.className = 'btn btn-primary';
        btn.innerText = 'Lấy';
        btn.addEventListener('click', (e) => {
          let data = {matx: row.MaTX, isfix: isFix};
          fetch(`http://127.0.0.1:8000/lay-thong-tin/`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify(data),
          }).then((res) => res.json()).then((json) => {
            createAlert('Tổng thu nhập hiện tại: ' + json.tongtien, 'Số lượng đơn hàng đã nhận: ' + json.sldonhang);
          });
        });
        td.appendChild(btn);
        tr.appendChild(td);
        tbody.appendChild(tr);
      }
    });
}

function layDonHangChuaNhan(type) {
  let tx1Port = '8000';
  if(type == '3') {
    tx1Port = '8008';
  }
  let container = document.getElementsByClassName('container')[0];
  container.innerHTML = '';
  container.insertAdjacentHTML('afterbegin', `
  <select name="chon-matx" id="chon-matx">
    <option value="TX0001 ${tx1Port}" selected="selected">Tai Xe 1</option>
    <option value="TX0002 8008">Tai Xe 2</option>
  </select>
  <table class="table">
    <thead>
      <tr>
        <th scope="col">Mã Đơn Hàng</th>
        <th scope="col"></th>
      </tr>
    </thead>
    <tbody>
    </tbody>
  </table>`);
  let tbody = document.querySelector("body > div.container > table > tbody");
  fetch("http://127.0.0.1:8000/lay-don-hang-chua-nhan/")
    .then((response) => response.json())
    .then((data) => {
      tbody.innerHTML = "";
      for (let i = 0; i < data.res.length; ++i) {
        let row = data.res[i];
        let tr = document.createElement('tr');
        tr.innerHTML = `<td>${row.MaDH}</td>`;
        let td = document.createElement('td');
        let btn = document.createElement('button');
        btn.className = 'btn btn-primary';
        btn.innerText = 'Nhận';
        btn.addEventListener('click', (e) => {
          let val = document.getElementById('chon-matx').value;
          let matx = val.split(" ")[0];
          let port = val.split(" ")[1];
          let data = {madh: row.MaDH, matx: matx, type: type};
          fetch(`http://127.0.0.1:${port}/nhan-don-hang/`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify(data),
          }).then((res) => res.json()).then((json) => {
            createAlert(json.msg);
          });
        });
        td.appendChild(btn);
        tr.appendChild(td);
        tbody.appendChild(tr);
      }
    });
}

function layDonHang() {
  let container = document.getElementsByClassName('container')[0];
  container.innerHTML = '';
  container.insertAdjacentHTML('afterbegin', `
  <table class="table">
    <thead>
      <tr>
        <th scope="col">Mã Đơn Hàng</th>
        <th scope="col">Phí Vận Chuyển</th>
        <th scope="col">Mã Tài Xế</th>
      </tr>
    </thead>
    <tbody>
    </tbody>
  </table>`);
  let tbody = document.querySelector("body > div.container > table > tbody");
  fetch("http://127.0.0.1:8000/lay-don-hang/")
    .then((response) => response.json())
    .then((data) => {
      tbody.innerHTML = "";
      for (let i = 0; i < data.res.length; ++i) {
        let row = data.res[i];
        tbody.insertAdjacentHTML('beforeend', `<td>${row.MaDH}</td>
        <td>${row.PhiVC}</td>
        <td>${row.MaTaiXe}</td>`);
      }
    });
}
function removeActive(cur) {
  for(let other of document.getElementsByClassName('nav-item')) {
    other.classList.remove('active');
  }
  cur.classList.add('active');
}
window.addEventListener("load", (event) => {
  document.getElementById('xdh').addEventListener('click', (e) => {
    layDonHang();
    removeActive(this);
  })
  document.getElementById('ndh').addEventListener('click', (e) => {
    layDonHangChuaNhan('1');
    removeActive(this);
  })
  document.getElementById('ndhf').addEventListener('click', (e) => {
    layDonHangChuaNhan('2');
    removeActive(this);
  })
  document.getElementById('ltt').addEventListener('click', (e) => {
    layThongTin(false);
    removeActive(this);
  })
  document.getElementById('lttf').addEventListener('click', (e) => {
    layThongTin(true);
    removeActive(this);
  })
  document.getElementById('ndhkd').addEventListener('click', (e) => {
    layDonHangChuaNhan('3');
    removeActive(this);
  })
  
  // let loginButton = document.getElementById('login');
  // loginButton.addEventListener('click', (e) => {
    
  //   if(isLogin) {
  //     loginButton.innerHTML = 'Logout';
  //   } else {
  //     loginButton.innerHTML = 'Login';
  //   }
  //   isLogin = !isLogin;
  // });
});s