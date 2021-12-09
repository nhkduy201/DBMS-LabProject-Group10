function createAlert(...data) {
  let container = document.getElementsByClassName('container')[0];
  for(let i = 0; i < data.length; ++i) {
    container.insertAdjacentHTML('afterbegin', `<div class="alert alert-primary" role="alert">
    ${data[i]}
    </div>`);
  }
}

function xemGiaSP(isFix) {
  let container = document.getElementsByClassName('container')[0];
  container.innerHTML = '';
  container.insertAdjacentHTML('afterbegin', `
    <div class="alert alert-primary" role="alert" id="htg">Giá: </div>
    <select id="cmsp">
      <option value="SP0001" selected="selected">San Pham 1</option>
      <option value="SP0002">San Pham 2</option>
    </select>
    <button id="xgbtn" class="btn btn-primary">Xem</button>`);
  let btn = document.getElementById('xgbtn');
        btn.addEventListener('click', (e) => {
          let data = {masp: document.getElementById("cmsp").value, isfix: isFix};
          fetch(`http://127.0.0.1:8008/xem-gia-san-pham/`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify(data),
          }).then((res) => res.json()).then((json) => {
            document.getElementById("htg").textContent = "Giá: " + json.gia;
          });
        });
}

function doiGiaSP() {
  let container = document.getElementsByClassName('container')[0];
  container.innerHTML = '';
  container.insertAdjacentHTML('afterbegin', `
    <select id="cmsp">
      <option value="SP0001" selected="selected">San Pham 1</option>
      <option value="SP0002">San Pham 2</option>
    </select>
    <input type="text" class="form-control" id="dgi">
    <button id="dgbtn" class="btn btn-primary">Đổi</button>`);
  let btn = document.getElementById('dgbtn');
        btn.addEventListener('click', (e) => {
          let data = {masp: document.getElementById("cmsp").value, gia: document.getElementById("dgi").value};
          fetch(`http://127.0.0.1:8000/doi-gia-san-pham/`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify(data),
          }).then((res) => res.json()).then((json) => {
            createAlert(json.msg);
          });
        });
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
window.addEventListener("load", (event) => {
  document.getElementById('xdh').addEventListener('click', (e) => {
    layDonHang();
  })
  document.getElementById('ndh').addEventListener('click', (e) => {
    layDonHangChuaNhan('1');
  })
  document.getElementById('ndhf').addEventListener('click', (e) => {
    layDonHangChuaNhan('2');
  })
  document.getElementById('ltt').addEventListener('click', (e) => {
    layThongTin(false);
  })
  document.getElementById('lttf').addEventListener('click', (e) => {
    layThongTin(true);
  })
  
  document.getElementById('ndhkd').addEventListener('click', (e) => {
    layDonHangChuaNhan('3');
  })

  document.getElementById('dgsp').addEventListener('click', (e) => {
    doiGiaSP();
  })
  
  document.getElementById('xgsp').addEventListener('click', (e) => {
    xemGiaSP(false);
  })
  
  document.getElementById('xgspf').addEventListener('click', (e) => {
    xemGiaSP(true);
  })
});