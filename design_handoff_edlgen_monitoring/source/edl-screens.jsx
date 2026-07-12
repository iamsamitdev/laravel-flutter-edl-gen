// EDL-Gen Monitoring — app screen scenes (3-language: lo / th / en · real inputs)
// Renders the static board (EDLBoard) and the interactive prototype (EDLPrototype).
// Reads window.IOSDevice / window.AndroidDevice from the frame starters.
const { useState } = React;

const C = {
  pri:'#1A5CB0', priLt:'#2E7BD6', priDk:'#0E3B78', gold:'#F4B700', goldDk:'#D99C00', red:'#D8232A',
  bg:'#F0F4FA', card:'#FFFFFF', border:'#D6E0EF',
  txDk:'#152641', txMd:'#44557A', txSb:'#7C8CA8',
  aGr:'#178A4C', aBg:'#DDF5E7', aTx:'#0E6338',
  pGr:'#D99C00', pBg:'#FFF4CC', pTx:'#7A5800',
  lRd:'#D8232A', lBg:'#FDE3E4', lTx:'#9B181D',
  cyBg:'#E1EEFB', cyTx:'#0E4E8F',
  dBg:'#0B1626', dCard:'#132238', dCard2:'#182B45', dBorder:'#24395B', dTx:'#E8F0FB', dSb:'#8299BE', dPri:'#5A9BE8',
};
const LAO = "'Noto Sans Lao','Phetsarath OT',sans-serif";
const TH  = "'Anuphan',sans-serif";
const NUM = "'Inter',sans-serif";
const BF = "'Inter','Anuphan','Noto Sans Lao',sans-serif";
const MONO = "'JetBrains Mono',monospace";
const h = React.createElement;

// ─── nav + form bridge (module-level, set by EDLPrototype each render) ───
const proto = { go:()=>{}, toggleDark:()=>{}, setLang:()=>{}, dark:false, lang:'lo', interactive:false, detail:{} };
const FORM = {}; // persists typed input values across screen switches
function openDetail(screen, data){ proto.detail = data||{}; proto.go(screen); }
function tap(fn){ return proto.interactive ? fn : undefined; }
function cur(){ return proto.interactive?'pointer':'default'; }
function ff(){ return proto.lang==='th'?TH : proto.lang==='en'?NUM : LAO; } // font for localized text

// ─── translations ───
const T = {
  lo:{
    proto_sub:'ຄລິກ tab ຫຼື ປຸ່ມພາຍໃນແອັບເພື່ອທ່ອງເບິ່ງ',
    tab_splash:'Splash', tab_login:'ເຂົ້າສູ່ລະບົບ', tab_dash:'ໜ້າຫຼັກ', tab_reports:'ລາຍງານ', tab_incident:'ແຈ້ງເຫດ', tab_detail:'ລາຍລະອຽດເຫດ', tab_meter:'ຈົດມິເຕີ', tab_notif:'ແຈ້ງເຕືອນ', tab_profile:'ໂປຣໄຟລ໌',
    nav_home:'ໜ້າຫຼັກ', nav_reports:'ລາຍງານ', nav_incident:'ແຈ້ງເຫດ', nav_meter:'ມິເຕີ', nav_profile:'ໂປຣໄຟລ໌',
    splash_sub:'ລະບົບຕິດຕາມການຜະລິດໄຟຟ້າ',
    greet:'ສະບາຍດີ 👋 ວິສະວະກອນ', name:'ຄຸນ ສົມໄຊ ວົງສາ',
    login_title:'ເຂົ້າສູ່ລະບົບ', login_sub:'ເຂົ້າສູ່ລະບົບເພື່ອຕິດຕາມການຜະລິດ',
    f_email:'ອີເມວ · Email', f_password:'ລະຫັດຜ່ານ · Password', login_forgot:'ລືມລະຫັດຜ່ານ?', login_btn:'ເຂົ້າສູ່ລະບົບ', login_foot:'ສຳລັບພະນັກງານ EDL-Generation ເທົ່ານັ້ນ',
    dash_total:'ກຳລັງຜະລິດລວມ', dash_freq:'ຄວາມຖີ່', dash_volt:'ແຮງດັນ', dash_water:'ນ້ຳ', dash_updated:'4 ໂຮງຜະລິດ · ອັບເດດ 3 ວິນາທີກ່ອນ', dash_chart:'ກຳລັງຜະລິດ · 30 ຄ່າຫຼ້າສຸດ', dash_plants:'ໂຮງຜະລິດ · Plants', dash_viewall:'ເບິ່ງທັງໝົດ',
    st_normal:'ປົກກະຕິ', st_maint:'ບຳລຸງຮັກສາ', st_watch:'ເຝົ້າລະວັງ',
    rep_title:'ບົດລາຍງານປະຈຳວັນ', rep_sub:'ການຜະລິດໄຟຟ້າ', off_title:'ໂໝດ Offline', off_body:'ສະແດງຂໍ້ມູນທີ່ບັນທຶກໄວ້ · ຂໍ້ມູນ ນ 14:32', rep_energy:'ພະລັງງານ', rep_water:'ລະດັບນ້ຳ',
    inc_title:'ແຈ້ງເຫດຂັດຂ້ອງ', inc_sub:'ເຄື່ອງຈັກ · Incident', f_plant:'ໂຮງຜະລິດ · Plant', f_title:'ຫົວຂໍ້ · Title', f_desc:'ລາຍລະອຽດ · Description', inc_sev:'ລະດັບຄວາມຮຸນແຮງ · Severity', sev_low:'ຕ່ຳ', sev_med:'ກາງ', sev_high:'ສູງ', sev_crit:'ວິກິດ', inc_photo:'ຮູບຖ່າຍ · Photo', inc_photo_hint:'ຖ່າຍຮູບເຄື່ອງຈັກ · tap to capture', inc_gps:'ພິກັດ GPS ຖືກແນບແລ້ວ', inc_submit:'ສົ່ງແຈ້ງເຫດ', inc_title_val:'Turbine #2 ສັ່ນຜິດປົກກະຕິ', inc_desc_val:'ພົບການສັ່ນ ແລະ ສຽງດັງຜິດປົກກະຕິ ໃນຊ່ວງເດີນເຄື່ອງເຕັມກຳລັງ',
    det_inprog:'ກຳລັງຊ່ອມ · In progress', det_plant:'ໂຮງຜະລິດ', det_by:'ແຈ້ງໂດຍ', det_time:'ເວລາ', det_coord:'ພິກັດ', det_timeline:'ສະຖານະ · Timeline', det_desc:'ພົບການສັ່ນ ແລະ ສຽງດັງຜິດປົກກະຕິ ໃນຊ່ວງເດີນເຄື່ອງເຕັມກຳລັງ ຄວນກວດເບິ່ງແບຣິ່ງ ແລະ ການດຸ່ນດ່ຽງໃບພັດ', det_reporter:'Somchai V. · ວິສະວະກອນ',
    tl_reported:'ແຈ້ງເຫດແລ້ວ · Reported', tl_ack:'ຫົວໜ້າກະຮັບຊາບ · Acknowledged', tl_prog:'ກຳລັງດຳເນີນການ · In progress', tl_resolved:'ແກ້ໄຂແລ້ວ · Resolved',
    mtr_title:'ຈົດຄ່າມິເຕີ', mtr_sub:'Meter Reading', f_metercode:'ລະຫັດມິເຕີ · Meter code', f_reading:'ຄ່າທີ່ອ່ານໄດ້ · Reading (kWh)', mtr_hour:'ບັນທຶກສຳລັບຊົ່ວໂມງ 14:00', mtr_save:'ບັນທຶກຄ່າມິເຕີ', mtr_today:'ບັນທຶກມື້ນີ້', mtr_pending:'ລໍຖ້າ', mtr_confirm:'ຢືນຢັນ', mtr_hourword:'ຊົ່ວໂມງ',
    ntf_title:'ການແຈ້ງເຕືອນ', ntf_sub:'3 ລາຍການໃໝ່', ntf_today:'ມື້ນີ້ · Today', ntf_yesterday:'ມື້ວານ · Yesterday',
    n1_t:'ແຈ້ງເຫດວິກິດ · Critical', n1_b:'Turbine #2 ສັ່ນຜິດປົກກະຕິ · Nam Theun 2', n2_t:'ບົດລາຍງານພ້ອມແລ້ວ', n2_b:'ບົດລາຍງານປະຈຳວັນ 15 ກ.ໍ. ຖືກສ້າງແລ້ວ', n3_t:'ໂຮງກັບມາເດີນເຄື່ອງ', n3_b:'Houay Ho ສິ້ນສຸດການບຳລຸງຮັກສາ', n4_t:'ເຕືອນຈົດມິເຕີ', n4_b:'ຍັງບໍ່ໄດ້ຈົດຄ່າມິເຕີ MTR-0043 ຊົ່ວໂມງ 16:00', n5_t:'ຄວາມຖີ່ຄືນສູ່ປົກກະຕິ', n5_b:'Xeset 2 ຄວາມຖີ່ 50.0 Hz',
    prof_sub:'ໂປຣໄຟລ໌ & ຕັ້ງຄ່າ', prof_role:'ວິສະວະກອນ · Nam Theun 2', prof_settings:'ການຕັ້ງຄ່າ · Settings', set_lang:'ພາສາ · Language', set_dark:'ໂໝດມືດ · Dark mode', set_notif:'ການແຈ້ງເຕືອນ · Notifications', set_about:'ກ່ຽວກັບແອັບ · About', prof_logout:'ອອກຈາກລະບົບ', lang_name:'ລາວ',
    critical:'ວິກິດ · Critical', month:'ກໍລະກົດ', mabbr:'ກ.ໍ.', year:'2569',
  },
  th:{
    proto_sub:'คลิก tab หรือปุ่มในแอปเพื่อท่องดู',
    tab_splash:'Splash', tab_login:'เข้าสู่ระบบ', tab_dash:'หน้าแรก', tab_reports:'รายงาน', tab_incident:'แจ้งเหตุ', tab_detail:'รายละเอียด', tab_meter:'มิเตอร์', tab_notif:'แจ้งเตือน', tab_profile:'โปรไฟล์',
    nav_home:'หน้าแรก', nav_reports:'รายงาน', nav_incident:'แจ้งเหตุ', nav_meter:'มิเตอร์', nav_profile:'โปรไฟล์',
    splash_sub:'ระบบติดตามการผลิตไฟฟ้า',
    greet:'สวัสดี 👋 วิศวกร', name:'คุณสมชาย วงศา',
    login_title:'เข้าสู่ระบบ', login_sub:'เข้าสู่ระบบเพื่อติดตามการผลิต',
    f_email:'อีเมล · Email', f_password:'รหัสผ่าน · Password', login_forgot:'ลืมรหัสผ่าน?', login_btn:'เข้าสู่ระบบ', login_foot:'สำหรับพนักงาน EDL-Generation เท่านั้น',
    dash_total:'กำลังผลิตรวม', dash_freq:'ความถี่', dash_volt:'แรงดัน', dash_water:'น้ำ', dash_updated:'4 โรงผลิต · อัปเดต 3 วินาทีก่อน', dash_chart:'กำลังผลิต · 30 ค่าล่าสุด', dash_plants:'โรงผลิต · Plants', dash_viewall:'ดูทั้งหมด',
    st_normal:'ปกติ', st_maint:'บำรุงรักษา', st_watch:'เฝ้าระวัง',
    rep_title:'รายงานการผลิตรายวัน', rep_sub:'การผลิตไฟฟ้า', off_title:'โหมด Offline', off_body:'แสดงข้อมูลที่บันทึกไว้ · ข้อมูล ณ 14:32', rep_energy:'พลังงาน', rep_water:'ระดับน้ำ',
    inc_title:'แจ้งเหตุขัดข้อง', inc_sub:'เครื่องจักร · Incident', f_plant:'โรงผลิต · Plant', f_title:'หัวข้อ · Title', f_desc:'รายละเอียด · Description', inc_sev:'ระดับความรุนแรง · Severity', sev_low:'ต่ำ', sev_med:'กลาง', sev_high:'สูง', sev_crit:'วิกฤต', inc_photo:'รูปถ่าย · Photo', inc_photo_hint:'ถ่ายรูปเครื่องจักร · แตะเพื่อถ่าย', inc_gps:'แนบพิกัด GPS แล้ว', inc_submit:'ส่งแจ้งเหตุ', inc_title_val:'Turbine #2 สั่นผิดปกติ', inc_desc_val:'พบการสั่นและเสียงดังผิดปกติช่วงเดินเครื่องเต็มกำลัง',
    det_inprog:'กำลังซ่อม · In progress', det_plant:'โรงผลิต', det_by:'แจ้งโดย', det_time:'เวลา', det_coord:'พิกัด', det_timeline:'สถานะ · Timeline', det_desc:'พบการสั่นและเสียงดังผิดปกติช่วงเดินเครื่องเต็มกำลัง ควรตรวจแบริ่งและการถ่วงดุลใบพัด', det_reporter:'Somchai V. · วิศวกร',
    tl_reported:'แจ้งเหตุแล้ว · Reported', tl_ack:'หัวหน้ากะรับทราบ · Acknowledged', tl_prog:'กำลังดำเนินการ · In progress', tl_resolved:'แก้ไขแล้ว · Resolved',
    mtr_title:'บันทึกค่ามิเตอร์', mtr_sub:'Meter Reading', f_metercode:'รหัสมิเตอร์ · Meter code', f_reading:'ค่าที่อ่านได้ · Reading (kWh)', mtr_hour:'บันทึกสำหรับชั่วโมง 14:00', mtr_save:'บันทึกค่ามิเตอร์', mtr_today:'บันทึกวันนี้', mtr_pending:'รอ', mtr_confirm:'ยืนยัน', mtr_hourword:'ชั่วโมง',
    ntf_title:'การแจ้งเตือน', ntf_sub:'3 รายการใหม่', ntf_today:'วันนี้ · Today', ntf_yesterday:'เมื่อวาน · Yesterday',
    n1_t:'แจ้งเหตุวิกฤต · Critical', n1_b:'Turbine #2 สั่นผิดปกติ · Nam Theun 2', n2_t:'รายงานพร้อมแล้ว', n2_b:'รายงานประจำวัน 15 ก.ค. ถูกสร้างแล้ว', n3_t:'โรงกลับมาเดินเครื่อง', n3_b:'Houay Ho สิ้นสุดการบำรุงรักษา', n4_t:'เตือนบันทึกมิเตอร์', n4_b:'ยังไม่ได้บันทึกมิเตอร์ MTR-0043 ชั่วโมง 16:00', n5_t:'ความถี่กลับสู่ปกติ', n5_b:'Xeset 2 ความถี่ 50.0 Hz',
    prof_sub:'โปรไฟล์ & ตั้งค่า', prof_role:'วิศวกร · Nam Theun 2', prof_settings:'การตั้งค่า · Settings', set_lang:'ภาษา · Language', set_dark:'โหมดมืด · Dark mode', set_notif:'การแจ้งเตือน · Notifications', set_about:'เกี่ยวกับแอป · About', prof_logout:'ออกจากระบบ', lang_name:'ไทย',
    critical:'วิกฤต · Critical', month:'กรกฎาคม', mabbr:'ก.ค.', year:'2569',
  },
  en:{
    proto_sub:'Click tabs or in-app buttons to navigate',
    tab_splash:'Splash', tab_login:'Login', tab_dash:'Home', tab_reports:'Reports', tab_incident:'Incident', tab_detail:'Detail', tab_meter:'Meter', tab_notif:'Alerts', tab_profile:'Profile',
    nav_home:'Home', nav_reports:'Reports', nav_incident:'Incident', nav_meter:'Meter', nav_profile:'Profile',
    splash_sub:'Power Generation Monitoring',
    greet:'Hello 👋 Engineer', name:'Somchai Vongsa',
    login_title:'Sign in', login_sub:'Sign in to monitor generation',
    f_email:'Email', f_password:'Password', login_forgot:'Forgot password?', login_btn:'Sign in', login_foot:'For EDL-Generation staff only',
    dash_total:'Total output', dash_freq:'Frequency', dash_volt:'Voltage', dash_water:'Water', dash_updated:'4 plants · updated 3s ago', dash_chart:'Power · last 30 readings', dash_plants:'Plants', dash_viewall:'View all',
    st_normal:'Normal', st_maint:'Maintenance', st_watch:'Watch',
    rep_title:'Daily reports', rep_sub:'Power generation', off_title:'Offline mode', off_body:'Showing cached data · as of 14:32', rep_energy:'Energy', rep_water:'Water level',
    inc_title:'Report incident', inc_sub:'Machinery · Incident', f_plant:'Plant', f_title:'Title', f_desc:'Description', inc_sev:'Severity', sev_low:'Low', sev_med:'Medium', sev_high:'High', sev_crit:'Critical', inc_photo:'Photo', inc_photo_hint:'Tap to capture machine photo', inc_gps:'GPS location attached', inc_submit:'Submit report', inc_title_val:'Turbine #2 abnormal vibration', inc_desc_val:'Abnormal vibration and noise at full load',
    det_inprog:'In progress', det_plant:'Plant', det_by:'Reported by', det_time:'Time', det_coord:'Coordinates', det_timeline:'Timeline', det_desc:'Abnormal vibration and noise at full load. Check bearings and blade balancing.', det_reporter:'Somchai V. · Engineer',
    tl_reported:'Reported', tl_ack:'Acknowledged', tl_prog:'In progress', tl_resolved:'Resolved',
    mtr_title:'Meter reading', mtr_sub:'Meter Reading', f_metercode:'Meter code', f_reading:'Reading (kWh)', mtr_hour:'Recording for hour 14:00', mtr_save:'Save reading', mtr_today:'Recorded today', mtr_pending:'Pending', mtr_confirm:'Confirmed', mtr_hourword:'Hour',
    ntf_title:'Notifications', ntf_sub:'3 new', ntf_today:'Today', ntf_yesterday:'Yesterday',
    n1_t:'Critical incident', n1_b:'Turbine #2 abnormal vibration · Nam Theun 2', n2_t:'Report ready', n2_b:'Daily report for Jul 15 generated', n3_t:'Plant back online', n3_b:'Houay Ho maintenance complete', n4_t:'Meter reminder', n4_b:'MTR-0043 reading for 16:00 not recorded', n5_t:'Frequency normalized', n5_b:'Xeset 2 frequency 50.0 Hz',
    prof_sub:'Profile & Settings', prof_role:'Engineer · Nam Theun 2', prof_settings:'Settings', set_lang:'Language', set_dark:'Dark mode', set_notif:'Notifications', set_about:'About', prof_logout:'Sign out', lang_name:'English',
    critical:'Critical', month:'Jul', mabbr:'Jul', year:'2026',
  },
};
Object.assign(T.lo,{
  tab_date:'ຊ່ວງວັນທີ', tab_camera:'ກ້ອງ', tab_gps:'ແຜນທີ່ GPS',
  dr_title:'ເລືອກຊ່ວງວັນທີ', dr_sub:'ບົດລາຍງານ', dr_from:'ວັນທີເລີ່ມ', dr_to:'ວັນທີສິ້ນສຸດ', dr_quick:'ໄລຍະດ່ວນ', dr_7:'7 ວັນ', dr_30:'30 ວັນ', dr_month:'ເດືອນນີ້', dr_apply:'ນຳໃຊ້', dr_wd:['ອາ','ຈ','ອ','ພ','ພຫ','ສຸ','ເສົາ'],
  cam_title:'ຖ່າຍຮູບເຄື່ອງຈັກ', cam_hint:'ຈັດເຄື່ອງຈັກໃຫ້ຢູ່ໃນກອບ', cam_capture:'ຖ່າຍຮູບ', cam_gallery:'ຄັງຮູບ', cam_flash:'ແຟລช',
  gps_title:'ຕຳແໜ່ງ GPS', gps_sub:'ແນບກັບການແຈ້ງເຫດ', gps_current:'ຕຳແໜ່ງປັດຈຸບັນ', gps_accuracy:'ຄວາມແມ່ນຍຳ ±4 m', gps_plant:'ໃກ້ Nam Theun 2 Hydro', gps_use:'ໃຊ້ຕຳແໜ່ງນີ້',
});
Object.assign(T.th,{
  tab_date:'ช่วงวันที่', tab_camera:'กล้อง', tab_gps:'แผนที่ GPS',
  dr_title:'เลือกช่วงวันที่', dr_sub:'รายงาน', dr_from:'วันที่เริ่ม', dr_to:'วันที่สิ้นสุด', dr_quick:'ช่วงด่วน', dr_7:'7 วัน', dr_30:'30 วัน', dr_month:'เดือนนี้', dr_apply:'ใช้งาน', dr_wd:['อา','จ','อ','พ','พฤ','ศ','ส'],
  cam_title:'ถ่ายรูปเครื่องจักร', cam_hint:'จัดเครื่องจักรให้อยู่ในกรอบ', cam_capture:'ถ่ายรูป', cam_gallery:'คลังรูป', cam_flash:'แฟลช',
  gps_title:'ตำแหน่ง GPS', gps_sub:'แนบกับการแจ้งเหตุ', gps_current:'ตำแหน่งปัจจุบัน', gps_accuracy:'ความแม่นยำ ±4 m', gps_plant:'ใกล้ Nam Theun 2 Hydro', gps_use:'ใช้ตำแหน่งนี้',
});
Object.assign(T.en,{
  tab_date:'Dates', tab_camera:'Camera', tab_gps:'Map',
  dr_title:'Select date range', dr_sub:'Reports', dr_from:'From', dr_to:'To', dr_quick:'Quick ranges', dr_7:'7 days', dr_30:'30 days', dr_month:'This month', dr_apply:'Apply', dr_wd:['S','M','T','W','T','F','S'],
  cam_title:'Capture machine photo', cam_hint:'Frame the machine', cam_capture:'Capture', cam_gallery:'Gallery', cam_flash:'Flash',
  gps_title:'GPS location', gps_sub:'Attach to incident', gps_current:'Current location', gps_accuracy:'Accuracy ±4 m', gps_plant:'Near Nam Theun 2 Hydro', gps_use:'Use this location',
});
Object.assign(T.lo,{
  det_status:'ສະຖານະ', pd_output:'ກຳລັງຜະລິດ', pd_energy_today:'ພະລັງງານມື້ນີ້', pd_uptime:'ຄວາມພ້ອມຈ່າຍ', pd_updated:'ອັບເດດ 3 ວິນາທີກ່ອນ',
  rd_peak:'ຄ່າສູງສຸດ', rd_hourly:'ການຜະລິດລາຍຊົ່ວໂມງ',
  md_reading:'ຄ່າທີ່ອ່ານໄດ້', md_prev:'ຄ່າກ່ອນໜ້າ', md_diff:'ຜົນຕ່າງ', md_by:'ບັນທຶກໂດຍ', md_time:'ເວລາ', md_meter:'ມິເຕີ',
});
Object.assign(T.th,{
  det_status:'สถานะ', pd_output:'กำลังผลิต', pd_energy_today:'พลังงานวันนี้', pd_uptime:'ความพร้อมจ่าย', pd_updated:'อัปเดต 3 วินาทีก่อน',
  rd_peak:'ค่าสูงสุด', rd_hourly:'การผลิตรายชั่วโมง',
  md_reading:'ค่าที่อ่านได้', md_prev:'ค่าก่อนหน้า', md_diff:'ผลต่าง', md_by:'บันทึกโดย', md_time:'เวลา', md_meter:'มิเตอร์',
});
Object.assign(T.en,{
  det_status:'Status', pd_output:'Power output', pd_energy_today:'Energy today', pd_uptime:'Availability', pd_updated:'updated 3s ago',
  rd_peak:'Peak', rd_hourly:'Hourly generation',
  md_reading:'Reading', md_prev:'Previous', md_diff:'Difference', md_by:'Recorded by', md_time:'Time', md_meter:'Meter',
});
Object.assign(T.lo,{
  tab_forgot:'ລືມລະຫັດ', fp_title:'ລືມລະຫັດຜ່ານ', fp_sub:'ຣີເຊັດລະຫັດຜ່ານ', fp_desc:'ປ້ອນອີເມວຂອງທ່ານ ພວກເຮົາຈະສົ່ງລິ້ງຣີເຊັດລະຫັດຜ່ານໄປໃຫ້', fp_send:'ສົ່ງລິ້ງຣີເຊັດ', fp_back:'ກັບໄປໜ້າເຂົ້າສູ່ລະບົບ', fp_note:'ລິ້ງຈະໝົດອາຍຸໃນ 15 ນາທີ',
});
Object.assign(T.th,{
  tab_forgot:'ลืมรหัส', fp_title:'ลืมรหัสผ่าน', fp_sub:'รีเซ็ตรหัสผ่าน', fp_desc:'กรอกอีเมลของคุณ เราจะส่งลิงก์รีเซ็ตรหัสผ่านไปให้', fp_send:'ส่งลิงก์รีเซ็ต', fp_back:'กลับไปหน้าเข้าสู่ระบบ', fp_note:'ลิงก์จะหมดอายุใน 15 นาที',
});
Object.assign(T.en,{
  tab_forgot:'Forgot', fp_title:'Forgot password', fp_sub:'Reset password', fp_desc:'Enter your email and we\u2019ll send you a link to reset your password', fp_send:'Send reset link', fp_back:'Back to sign in', fp_note:'The link expires in 15 minutes',
});
function t(key){ return (T[proto.lang]&&T[proto.lang][key]) ?? T.lo[key] ?? key; }
function repDate(day){ return proto.lang==='en' ? `${t('month')} ${day}, ${t('year')}` : `${day} ${t('month')} ${t('year')}`; }

// ─── icons ───
const IP = {
  home:[["path",{d:"M3 11.9896V14.5C3 17.7998 3 19.4497 4.02513 20.4749C5.05025 21.5 6.70017 21.5 10 21.5H14C17.2998 21.5 18.9497 21.5 19.9749 20.4749C21 19.4497 21 17.7998 21 14.5V11.9896C21 10.3083 21 9.46773 20.6441 8.74005C20.2882 8.01237 19.6247 7.49628 18.2976 6.46411L16.2976 4.90855C14.2331 3.30285 13.2009 2.5 12 2.5C10.7991 2.5 9.76689 3.30285 7.70242 4.90855L5.70241 6.46411C4.37533 7.49628 3.71179 8.01237 3.3559 8.74005C3 9.46773 3 10.3083 3 11.9896Z"}],["path",{d:"M15 21.5V16.5C15 15.0858 15 14.3787 14.5607 13.9393C14.1213 13.5 13.4142 13.5 12 13.5C10.5858 13.5 9.87868 13.5 9.43934 13.9393C9 14.3787 9 15.0858 9 16.5V21.5"}]],
  doc:[["path",{d:"M8 7h8"}],["path",{d:"M8 11h5"}],["path",{d:"M13 21.5V21c0-2.8 0-4.2.9-5.1s2.3-.9 5.1-.9h.5M20 13.3V10c0-3.8 0-5.7-1.2-6.8S15.8 2 12 2 6.3 2 5.2 3.2 4 6.2 4 10v4.5c0 3.3 0 4.9.9 6 .2.2.4.4.6.6 1.1.9 2.7.9 5.9.9.7 0 1.1 0 1.4-.1.3-.2.5-.4 1-.9l4.7-4.7c.6-.6.9-.9 1-1.3s.2-.8.2-1.6z"}]],
  alert:[["path",{d:"M5.3 9.7C7.7 5.4 9 3.3 10.6 2.7a4 4 0 0 1 2.8 0c1.7.6 2.9 2.7 5.3 7s3.6 6.4 3.3 8.1a4 4 0 0 1-1.4 2.5C19.2 21.5 16.8 21.5 12 21.5S4.8 21.5 3.5 20.3a4 4 0 0 1-1.4-2.5c-.4-1.7.8-3.8 3.2-8.1z"}],["path",{d:"M12 16h0"}],["path",{d:"M12 13V9"}]],
  meter:[["path",{d:"M2.5 12C2.5 7.5 2.5 5.3 3.9 3.9S7.5 2.5 12 2.5s6.7 0 8.1 1.4S21.5 7.5 21.5 12s0 6.7-1.4 8.1S16.5 21.5 12 21.5s-6.7 0-8.1-1.4S2.5 16.5 2.5 12z"}],["path",{d:"M16 8l-4 4c-.5.5-.5.7-.5 1a1 1 0 0 0 1.5.5L16 11"}],["path",{d:"M7 16.5h10"}]],
  user:[["path",{d:"M17 8.5a5 5 0 1 0-10 0 5 5 0 0 0 10 0z"}],["path",{d:"M19 20.5a7 7 0 0 0-14 0"}]],
  bell:[["path",{d:"M20 18.5 18.3 7.9C17.9 4.8 15.2 2.5 12 2.5S6.1 4.8 5.7 7.9L4 18.5"}],["path",{d:"M20 18.5c0-1.7-3.6-3-8-3s-8 1.3-8 3 3.6 3 8 3 8-1.3 8-3z"}],["path",{d:"M13 18.5h-2"}]],
  lock:[["path",{d:"M12 16.5v-2"}],["path",{d:"M4.3 18.8c.2 1.7 1.6 3 3.3 3.1 1.4.1 2.8.1 4.4.1s3 0 4.4-.1c1.7-.1 3.1-1.4 3.3-3.1.1-1.1.3-2.2.3-3.3s-.1-2.3-.3-3.3c-.2-1.7-1.6-3-3.3-3.1C15 9 13.6 9 12 9s-3 0-4.4.1c-1.7.1-3.1 1.4-3.3 3.1C4.1 13.2 4 14.4 4 15.5s.1 2.3.3 3.3z"}],["path",{d:"M7.5 9V6.5a4.5 4.5 0 0 1 9 0V9"}]],
  mail:[["path",{d:"M2 6l6.9 3.9c1.6.9 2.6.9 4.2 0L20 6"}],["path",{d:"M2 13.5c.1 3 .1 4.6 1.2 5.7s2.7 1.2 5.9 1.3c1.9 0 3.8 0 5.8 0 3.1-.1 4.7-.1 5.8-1.3s1.2-2.7 1.2-5.7c0-1 0-2 0-3-.1-3.1-.1-4.6-1.2-5.7S24.5 3.6 21.3 3.5a70 70 0 0 0-5.8 0c-3.1.1-4.7.1-5.8 1.3S8.1 7.5 8 10.5c0 1 0 2 0 3z","transform":"translate(-6 0)"}]],
  eye:[["path",{d:"M21.5 11C21.8 11.5 22 11.7 22 12s-.2.5-.5 1C20.2 14.9 16.7 19 12 19S3.8 14.9 2.5 13c-.3-.5-.5-.7-.5-1s.2-.5.5-1C3.8 9.1 7.3 5 12 5s8.2 4.1 9.5 6z"}],["path",{d:"M15 12a3 3 0 1 0-6 0 3 3 0 0 0 6 0z"}]],
  logout:[["path",{d:"M18 18c0 .5 0 .7 0 .9-.2 1.6-1.5 2.9-3.1 3.1-.2 0-.4 0-.9 0H11c-3.3 0-4.9 0-6-1S4 18.3 4 15V9C4 5.7 4 4.1 5 3s2.7-1 6-1h3c.5 0 .7 0 .9 0 1.6.2 2.9 1.5 3.1 3.1 0 .2 0 .4 0 .9"}],["path",{d:"M8 12h6"}],["path",{d:"M11.5 9.5 14 12l-2.5 2.5"}]],
  camera:[["path",{d:"M7 6c-1.2 0-1.9 0-2.5.3-.7.3-1.4.9-1.7 1.7C2.5 8.6 2.4 9.4 2.3 11l-.1 2.5c-.3 4 .4 5.9 1.6 7.2S6.1 22 10 22h4c3.9 0 5.9 0 7-1.3s1.9-3.2 1.7-7.2l-.1-2.5c-.1-1.6-.2-2.4-.5-3-.4-.8-1-1.4-1.8-1.7C19.6 6 18.9 6 17.7 6"}],["path",{d:"M17 7l-.9-2.2C15.7 3.8 15.4 2.8 14.4 2.3 13.9 2 13.3 2 12 2s-1.9 0-2.4.3c-1 .5-1.3 1.5-1.7 2.5L7 7"}],["path",{d:"M15.5 14a3.5 3.5 0 1 0-7 0 3.5 3.5 0 0 0 7 0z"}]],
  pin:[["path",{d:"M13.6 21.4a2.4 2.4 0 0 1-3.2 0C6.4 17.6 1.1 13.4 3.7 7.4A9 9 0 0 1 12 2a9 9 0 0 1 8.3 5.4c2.6 6-2.7 10.2-6.7 14z"}],["path",{d:"M15.5 11a3.5 3.5 0 1 0-7 0 3.5 3.5 0 0 0 7 0z"}]],
  clock:[["circle",{cx:12,cy:12,r:10}],["path",{d:"M12 8v4l2 2"}]],
  checkCircle:[["path",{d:"M22 12a10 10 0 1 0-20 0 10 10 0 0 0 20 0z"}],["path",{d:"M8 12.5 10.5 15 16 9"}]],
  wifiOff:[["path",{d:"M2 8.8A15 15 0 0 1 16.3 5.2"}],["path",{d:"M19.5 7c.9.5 1.8 1.1 2.5 1.8"}],["path",{d:"M5.5 12.9A9 9 0 0 1 13.5 10.1"}],["path",{d:"M18.5 12.9c-.6-.6-1.2-1.1-1.9-1.5"}],["path",{d:"M8.5 16.4a5.4 5.4 0 0 1 7 0"}],["path",{d:"M12 19.5h0"}],["path",{d:"M3 3l18 18"}]],
  filter:[["path",{d:"M3 7h18"}],["path",{d:"M6 12h12"}],["path",{d:"M10 17h4"}]],
  chevronR:[["path",{d:"M9 6s6 4.4 6 6-6 6-6 6"}]],
  chevronL:[["path",{d:"M15 6s-6 4.4-6 6 6 6 6 6"}]],
  chevronD:[["path",{d:"M18 9s-4.4 6-6 6-6-6-6-6"}]],
  globe:[["path",{d:"M22 12a10 10 0 1 0-20 0 10 10 0 0 0 20 0z"}],["path",{d:"M2 12h20"}],["path",{d:"M12 2c2.5 2.7 3.9 6.3 4 10-.1 3.7-1.5 7.3-4 10-2.5-2.7-3.9-6.3-4-10 .1-3.7 1.5-7.3 4-10z"}]],
  moon:[["path",{d:"M21.5 14a9 9 0 0 1-4 1 8.6 8.6 0 0 1-8.6-8.6c0-1.5.4-2.8 1-4A9.4 9.4 0 0 0 2.5 11.9 9.6 9.6 0 0 0 12.1 21.5 9.5 9.5 0 0 0 21.5 14z"}]],
  flash:[["path",{d:"M13 2 4.1 12.7c-.4.4-.5.7-.4 1s.4.5.9.5l6.4-.2-1.4 8c-.1.6.4.9.8.5L19.9 11c.4-.4.5-.7.4-1s-.4-.5-.9-.5l-6.4.2 1.4-8c.1-.6-.4-.9-.8-.5z"}]],
  water:[["path",{d:"M4 13.7c0-4.7 3.8-9.3 6.4-12 .5-.5.7-.7 1.1-.7s.6.2 1.1.7c2.6 2.7 6.4 7.3 6.4 12 0 4.6-3.4 8.3-7.5 8.3S4 18.3 4 13.7z"}]],
  send:[["path",{d:"M21 3C18.9.7 2.5 6.5 2.5 8.6c0 2.4 6.4 3.1 8.2 3.6.5.1.8.5.8 1.1.9 5 1.4 7.5 2.7 7.6 2 .1 8-16.2 6.8-17.5z"}],["path",{d:"M11.5 12.5 15 9"}]],
  refresh:[["path",{d:"M20.5 5.5H9.5C5.8 5.5 3 8.2 3 12"}],["path",{d:"M3.5 18.5H14.5C18.2 18.5 21 15.8 21 12"}],["path",{d:"M18.5 3s2 1.8 2 2.5-2 2.5-2 2.5"}],["path",{d:"M5.5 16S3.5 17.8 3.5 18.5 5.5 21 5.5 21"}]],
  wrench:[["path",{d:"M5.1 15.3 9.1 11.4A6 6 0 0 1 10.1 3.8 6 6 0 0 1 16.9 2.4L13.2 6.1l.7 3 3 .7 3.7-3.7A6 6 0 0 1 19.2 12.9 6 6 0 0 1 11.6 13.9L7.7 17.9A1.7 1.7 0 0 1 5.1 15.3z"}],["path",{d:"M6 18 3.5 20.5"}]],
  gauge:[["circle",{cx:12,cy:12,r:9}],["path",{d:"M12 12 16 8"}],["path",{d:"M12 3v2M3 12h2M19 12h2"}]],
  edit:[["path",{d:"M14 4l6 6"}],["path",{d:"M4.8 14 14 4.8a2.7 2.7 0 0 1 3.8 0l.4.4a2.7 2.7 0 0 1 0 3.8L9 18.2c-.5.5-.8.8-1.2.9l-3.6 1c-.6.2-1.2-.4-1-1l1-3.6c.1-.4.4-.7.9-1.2z"}]],
  info:[["circle",{cx:12,cy:12,r:10}],["path",{d:"M12 16v-4.5"}],["path",{d:"M12 8h0"}]],
};
function ic(name, size=24, color='currentColor', sw=1.6, key) {
  return h('svg',{key,viewBox:'0 0 24 24',width:size,height:size,fill:'none',stroke:color,strokeWidth:sw,strokeLinecap:'round',strokeLinejoin:'round',style:{display:'block',flexShrink:0}},
    ...(IP[name]||[]).map((p,i)=>h(p[0],{key:i,...p[1]})));
}

// ─── shared bits ───
function stripePlaceholder(label, height, dark){
  return h('div',{style:{height,borderRadius:14,border:`1.5px dashed ${dark?C.dBorder:C.border}`,background:`repeating-linear-gradient(135deg,${dark?'#0f1d30':'#EDF2F9'},${dark?'#0f1d30':'#EDF2F9'} 9px,${dark?'#12233a':'#E4EBF5'} 9px,${dark?'#12233a':'#E4EBF5'} 18px)`,display:'flex',flexDirection:'column',alignItems:'center',justifyContent:'center',gap:7,color:dark?C.dSb:C.txSb}},
    ic('camera',26,dark?C.dSb:C.txSb,1.5),
    h('span',{style:{fontFamily:ff(),fontSize:11}},label));
}
function badge(label,bg,tx,dot){
  return h('span',{style:{display:'inline-flex',alignItems:'center',gap:6,background:bg,color:tx,fontSize:11,fontWeight:700,padding:'4px 11px',borderRadius:20,fontFamily:ff(),whiteSpace:'nowrap'}},
    dot?h('span',{style:{width:7,height:7,borderRadius:'50%',background:dot,display:'block'}}):null,label);
}
function statusPad(platform){ return platform==='ios'?54:6; }

function header(platform, title, sub, opts={}){
  const dark = opts.dark;
  return h('div',{style:{background:'linear-gradient(155deg,#2E7BD6 0%,#1A5CB0 55%,#0E3B78 100%)',padding:`${statusPad(platform)+14}px 18px 18px`,position:'relative',overflow:'hidden'}},
    h('div',{style:{position:'absolute',right:-30,top:-30,width:130,height:130,borderRadius:'50%',background:'rgba(255,255,255,0.06)'}}),
    h('div',{style:{position:'absolute',right:70,bottom:-50,width:100,height:100,borderRadius:'50%',background:'rgba(244,183,0,0.12)'}}),
    h('div',{style:{position:'relative',zIndex:1,display:'flex',alignItems:'center',justifyContent:'space-between'}},
      opts.back
        ? h('div',{onClick:tap(()=>proto.go(opts.back===true?'incident':opts.back)),style:{display:'flex',alignItems:'center',gap:10,cursor:cur()}},
            h('div',{style:{width:36,height:36,borderRadius:11,background:'rgba(255,255,255,0.16)',display:'flex',alignItems:'center',justifyContent:'center'}},ic('chevronL',20,'#fff',2)),
            h('div',{},
              sub?h('div',{style:{color:'rgba(255,255,255,0.7)',fontSize:11,fontFamily:MONO,marginBottom:2}},sub):null,
              h('div',{style:{color:'#fff',fontSize:19,fontWeight:700,fontFamily:ff()}},title)))
        : h('div',{},
            sub?h('div',{style:{color:'rgba(255,255,255,0.72)',fontSize:12.5,fontFamily:ff(),marginBottom:2}},sub):null,
            h('div',{style:{color:'#fff',fontSize:21,fontWeight:700,fontFamily:ff(),letterSpacing:'-0.01em'}},title)),
      opts.bell!==false && !opts.back
        ? h('div',{onClick:tap(()=>proto.go('notifications')),style:{position:'relative',width:40,height:40,borderRadius:12,background:'rgba(255,255,255,0.16)',display:'flex',alignItems:'center',justifyContent:'center',cursor:cur()}},ic('bell',20,'#fff',1.8),h('span',{style:{position:'absolute',top:9,right:10,width:8,height:8,borderRadius:'50%',background:C.gold,border:'1.5px solid #1f5aa0'}}))
        : null),
    opts.children?h('div',{style:{position:'relative',zIndex:1,marginTop:14}},opts.children):null);
}

function navBar(active, platform, dark, go){
  go = go || (()=>{});
  const items=[['home',t('nav_home'),'dashboard'],['doc',t('nav_reports'),'reports'],['alert',t('nav_incident'),'incident'],['meter',t('nav_meter'),'meter'],['user',t('nav_profile'),'profile']];
  const bg = dark?C.dCard:C.card, bord = dark?C.dBorder:C.border;
  return h('div',{style:{background:bg,borderTop:`1px solid ${bord}`,display:'flex',alignItems:'flex-end',justifyContent:'space-around',padding:`9px 6px ${platform==='ios'?20:12}px`,flexShrink:0}},
    ...items.map((it,i)=>{
      const on = it[2]===active;
      if(it[2]==='incident'){
        return h('div',{key:i,onClick:tap(()=>go('incident')),style:{display:'flex',flexDirection:'column',alignItems:'center',gap:5,transform:'translateY(-6px)',cursor:cur()}},
          h('div',{style:{width:46,height:46,borderRadius:'50%',background:C.lRd,display:'flex',alignItems:'center',justifyContent:'center',boxShadow:'0 6px 16px rgba(216,35,42,0.4)'}},ic('alert',24,'#fff',1.9)),
          h('span',{style:{fontSize:9.5,fontWeight:700,color:on?C.lRd:(dark?C.dSb:C.txSb),fontFamily:ff()}},it[1]));
      }
      const col = on?(dark?C.dPri:C.pri):(dark?C.dSb:C.txSb);
      return h('div',{key:i,onClick:tap(()=>go(it[2])),style:{display:'flex',flexDirection:'column',alignItems:'center',gap:5,flex:1,cursor:cur()}},
        ic(it[0],23,col,on?2:1.6),
        h('span',{style:{fontSize:9.5,fontWeight:on?700:500,color:col,fontFamily:ff()}},it[1]));
    }));
}

// static value field
function fieldRow(label, value, iconName, dark, opts={}){
  return h('div',{key:label,style:{marginBottom:14}},
    h('div',{style:{fontSize:12.5,fontWeight:600,color:dark?C.dTx:C.txDk,marginBottom:6,fontFamily:ff()}},label),
    h('div',{style:{background:dark?C.dCard2:C.card,border:`1.5px solid ${opts.err?C.lRd:(dark?C.dBorder:C.border)}`,borderRadius:12,padding:'12px 14px',display:'flex',alignItems:'center',gap:9}},
      iconName?ic(iconName,18,dark?C.dSb:C.txSb,1.6):null,
      h('span',{style:{flex:1,fontSize:15,color:value?(dark?C.dTx:C.txDk):(dark?C.dSb:C.txSb),fontFamily:opts.mono?MONO:ff()}},value||opts.ph||'...'),
      opts.trail?ic(opts.trail,18,dark?C.dSb:C.txSb,1.6):null),
    opts.err?h('div',{style:{fontSize:11,color:C.lRd,marginTop:5,fontFamily:ff()}},opts.err):null);
}

// real typeable field (uncontrolled, value persists in FORM across re-renders/screens)
function fieldInput(id, label, iconName, dark, opts={}){
  const dflt = FORM[id]!==undefined ? FORM[id] : (opts.preset||'');
  const inputStyle={flex:1,border:'none',outline:'none',background:'transparent',fontSize:15,color:dark?C.dTx:C.txDk,fontFamily:opts.mono?MONO:ff(),padding:0,minWidth:0,width:'100%'};
  const editable = proto.interactive;
  const inputEl = opts.textarea
    ? h('textarea',{key:'i',defaultValue:dflt,placeholder:opts.ph,readOnly:!editable,rows:opts.rows||3,onChange:e=>{FORM[id]=e.target.value},style:{...inputStyle,resize:'none',lineHeight:1.5,fontSize:13.5}})
    : h('input',{key:'i',type:opts.type||'text',defaultValue:dflt,placeholder:opts.ph,readOnly:!editable,inputMode:opts.inputMode,onChange:e=>{FORM[id]=e.target.value},style:inputStyle});
  const eyeBtn = opts.eye ? h('div',{key:'e',onClick:(e)=>{const inp=e.currentTarget.parentNode.querySelector('input');if(inp)inp.type=inp.type==='password'?'text':'password';},style:{cursor:'pointer',flexShrink:0}},ic('eye',18,dark?C.dSb:C.txSb,1.6)) : (opts.trail?ic(opts.trail,18,dark?C.dSb:C.txSb,1.6):null);
  return h('div',{key:label,style:{marginBottom:14}},
    h('div',{style:{fontSize:12.5,fontWeight:600,color:dark?C.dTx:C.txDk,marginBottom:6,fontFamily:ff()}},label),
    h('div',{style:{background:dark?C.dCard2:C.card,border:`1.5px solid ${opts.err?C.lRd:(dark?C.dBorder:C.border)}`,borderRadius:12,padding:opts.textarea?'10px 14px':'12px 14px',display:'flex',alignItems:opts.textarea?'flex-start':'center',gap:9}},
      iconName?ic(iconName,18,dark?C.dSb:C.txSb,1.6):null,
      inputEl, eyeBtn),
    opts.err?h('div',{style:{fontSize:11,color:C.lRd,marginTop:5,fontFamily:ff()}},opts.err):null);
}

// ─── SCREENS ───
function scr_splash(platform, dark){
  return h('div',{onClick:tap(()=>proto.go('login')),style:{height:'100%',cursor:cur(),background:'linear-gradient(165deg,#2E7BD6 0%,#1A5CB0 50%,#0E3B78 100%)',display:'flex',flexDirection:'column',alignItems:'center',justifyContent:'center',position:'relative',overflow:'hidden'}},
    h('div',{style:{position:'absolute',right:-60,top:60,width:220,height:220,borderRadius:'50%',background:'rgba(255,255,255,0.05)'}}),
    h('div',{style:{position:'absolute',left:-50,bottom:120,width:180,height:180,borderRadius:'50%',background:'rgba(244,183,0,0.1)'}}),
    h('div',{style:{background:'#fff',borderRadius:'50%',padding:10,boxShadow:'0 16px 50px rgba(0,0,0,0.3)',marginBottom:26}},
      h('img',{src:'assets/edl-gen-logo.jfif',style:{width:104,height:104,borderRadius:'50%',display:'block',objectFit:'contain'}})),
    h('div',{style:{color:'#fff',fontSize:27,fontWeight:700,fontFamily:NUM,letterSpacing:'-0.01em'}},'EDL-Gen Monitoring'),
    h('div',{style:{color:'rgba(255,255,255,0.78)',fontSize:14,fontFamily:ff(),marginTop:8,textAlign:'center',lineHeight:1.5}},t('splash_sub')),
    h('div',{style:{position:'absolute',bottom:platform==='ios'?66:44,display:'flex',flexDirection:'column',alignItems:'center',gap:16}},
      h('div',{style:{width:26,height:26,border:'2.5px solid rgba(255,255,255,0.25)',borderTopColor:'#F4B700',borderRadius:'50%',animation:'spin 0.8s linear infinite'}}),
      h('div',{style:{color:'rgba(255,255,255,0.5)',fontSize:11,fontFamily:MONO}},'EDL-GEN O&M · v1.0')));
}

function langSeg(){
  const seg=(code,label,fam)=>{const on=proto.lang===code;return h('span',{key:code,onClick:tap(()=>proto.setLang(code)),style:{fontSize:12.5,fontWeight:700,padding:'7px 16px',borderRadius:18,cursor:cur(),background:on?'linear-gradient(135deg,#2E7BD6,#1A5CB0)':'transparent',color:on?'#fff':C.txSb,fontFamily:fam}},label);};
  return h('div',{style:{display:'flex',background:C.bg,borderRadius:22,padding:4}},seg('lo','ລາວ',LAO),seg('th','ไทย',TH),seg('en','EN',NUM));
}

function scr_login(platform, dark){
  return h('div',{style:{height:'100%',background:C.card,display:'flex',flexDirection:'column',overflow:'auto'}},
    h('div',{style:{paddingTop:statusPad(platform)+30,paddingBottom:24,background:'linear-gradient(165deg,#2E7BD6,#1A5CB0 60%,#0E3B78)',display:'flex',flexDirection:'column',alignItems:'center'}},
      h('div',{style:{background:'#fff',borderRadius:'50%',padding:7,boxShadow:'0 10px 30px rgba(0,0,0,0.25)'}},h('img',{src:'assets/edl-gen-logo.jfif',style:{width:66,height:66,borderRadius:'50%',display:'block',objectFit:'contain'}})),
      h('div',{style:{color:'#fff',fontSize:19,fontWeight:700,fontFamily:NUM,marginTop:14}},'EDL-Gen Monitoring')),
    h('div',{style:{padding:'24px 22px 18px',flex:1}},
      h('div',{style:{display:'flex',justifyContent:'center',marginBottom:22}},langSeg()),
      h('div',{style:{fontSize:22,fontWeight:700,color:C.txDk,fontFamily:ff(),marginBottom:4}},t('login_title')),
      h('div',{style:{fontSize:13,color:C.txSb,fontFamily:ff(),marginBottom:22}},t('login_sub')),
      fieldInput('email',t('f_email'),'mail',false,{preset:'engineer@edlgen.la',type:'email',inputMode:'email',ph:'name@edlgen.la'}),
      fieldInput('password',t('f_password'),'lock',false,{preset:'edlgen123',type:'password',eye:true}),
      h('div',{style:{textAlign:'right',marginTop:-4,marginBottom:20}},h('span',{onClick:tap(()=>proto.go('forgot')),style:{fontSize:12.5,color:C.pri,fontWeight:600,fontFamily:ff(),cursor:cur()}},t('login_forgot'))),
      h('button',{onClick:tap(()=>proto.go('dashboard')),style:{width:'100%',background:'linear-gradient(135deg,#2E7BD6,#1A5CB0)',color:'#fff',border:'none',borderRadius:14,padding:'15px',fontSize:15.5,fontWeight:700,fontFamily:ff(),cursor:cur(),display:'flex',alignItems:'center',justifyContent:'center',gap:9,boxShadow:'0 6px 22px rgba(26,92,176,0.32)'}},ic('logout',19,'#fff',2),t('login_btn')),
      h('div',{style:{textAlign:'center',marginTop:22,fontSize:11.5,color:C.txSb,fontFamily:ff(),lineHeight:1.6}},t('login_foot'),h('br'),h('span',{style:{fontFamily:MONO,fontSize:10.5}},'Laravel Sanctum · Token 60 min'))));
}

function miniChart(dark){
  const pts=[62,70,58,74,80,66,84,78,90,86,94,88,82,90,96];
  const w=300,hh=88,max=100,min=50,step=w/(pts.length-1);
  const y=v=>hh-((v-min)/(max-min))*hh;
  const line=pts.map((v,i)=>`${i*step},${y(v)}`).join(' ');
  const area=`0,${hh} ${line} ${w},${hh}`;
  return h('svg',{viewBox:`0 0 ${w} ${hh}`,width:'100%',height:hh,preserveAspectRatio:'none',style:{display:'block'}},
    h('defs',{},h('linearGradient',{id:'g'+(dark?'d':'l'),x1:0,y1:0,x2:0,y2:1},
      h('stop',{offset:'0%',stopColor:dark?'#5A9BE8':'#2E7BD6',stopOpacity:0.35}),
      h('stop',{offset:'100%',stopColor:dark?'#5A9BE8':'#2E7BD6',stopOpacity:0}))),
    h('polygon',{points:area,fill:`url(#g${dark?'d':'l'})`}),
    h('polyline',{points:line,fill:'none',stroke:dark?'#5A9BE8':'#2E7BD6',strokeWidth:2.5,strokeLinecap:'round',strokeLinejoin:'round'}));
}

function scr_dashboard(platform, dark){
  const bg=dark?C.dBg:C.bg, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb;
  const plant=(name,mw,st,stBg,stTx,dot)=>h('div',{key:name,onClick:tap(()=>openDetail('plantDetail',{name,mw,st,stBg,stTx,dot})),style:{background:cd,borderRadius:14,padding:'12px 14px',display:'flex',alignItems:'center',gap:12,border:`1px solid ${bd}`,cursor:cur()}},
    h('div',{style:{width:40,height:40,borderRadius:11,background:dark?'#12233a':'#E1EEFB',display:'flex',alignItems:'center',justifyContent:'center',flexShrink:0}},ic('water',21,dark?C.dPri:C.pri,1.6)),
    h('div',{style:{flex:1,minWidth:0}},
      h('div',{style:{fontSize:13,fontWeight:700,color:tx,fontFamily:BF}},name),
      h('div',{style:{fontSize:15,fontWeight:700,color:dark?C.dPri:C.pri,fontFamily:NUM}},mw,h('span',{style:{fontSize:11,color:sb,fontWeight:600}},' MW'))),
    badge(st,stBg,stTx,dot),
    h('div',{style:{marginLeft:2}},ic('chevronR',17,sb,2)));
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg}},
    header(platform,t('name'),t('greet'),{dark}),
    h('div',{style:{flex:1,overflow:'auto',padding:'0 16px 16px',marginTop:-4}},
      h('div',{style:{background:'linear-gradient(140deg,#2E7BD6,#1A5CB0 55%,#0E3B78)',borderRadius:18,padding:16,marginTop:14,boxShadow:'0 8px 24px rgba(26,92,176,0.28)',position:'relative',overflow:'hidden'}},
        h('div',{style:{position:'absolute',right:-16,top:-16,width:90,height:90,borderRadius:'50%',background:'rgba(255,255,255,0.06)'}}),
        h('div',{style:{position:'relative',zIndex:1}},
          h('div',{style:{display:'flex',justifyContent:'space-between',alignItems:'center'}},
            h('span',{style:{color:'rgba(255,255,255,0.7)',fontSize:11.5,fontFamily:ff()}},t('dash_total')),
            badge('● LIVE','rgba(255,255,255,0.18)','#fff')),
          h('div',{style:{display:'flex',alignItems:'baseline',gap:6,margin:'8px 0 2px'}},
            h('span',{style:{color:'#fff',fontSize:36,fontWeight:700,fontFamily:NUM}},'102.5'),
            h('span',{style:{color:C.gold,fontSize:16,fontWeight:700}},'MW')),
          h('div',{style:{color:'rgba(255,255,255,0.6)',fontSize:11,fontFamily:ff(),marginBottom:12}},t('dash_updated')),
          h('div',{style:{display:'flex',gap:9}},
            ...[[t('dash_freq'),'50.02','Hz'],[t('dash_volt'),'22.87','kV'],[t('dash_water'),'198.4','m']].map((s,i)=>h('div',{key:i,style:{flex:1,background:'rgba(255,255,255,0.13)',borderRadius:11,padding:'9px 10px'}},
              h('div',{style:{color:'rgba(255,255,255,0.55)',fontSize:9.5,fontFamily:ff(),marginBottom:3}},s[0]),
              h('div',{style:{color:'#fff',fontSize:15,fontWeight:700,fontFamily:NUM}},s[1],h('span',{style:{fontSize:9,color:'rgba(255,255,255,0.6)'}},' '+s[2]))))))),
      h('div',{style:{background:cd,borderRadius:16,padding:14,marginTop:14,border:`1px solid ${bd}`}},
        h('div',{style:{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:10}},
          h('span',{style:{fontSize:12.5,fontWeight:700,color:tx,fontFamily:ff()}},t('dash_chart')),
          badge('MW',dark?'#12233a':'#E1EEFB',dark?C.dPri:C.cyTx)),
        miniChart(dark),
        h('div',{style:{display:'flex',justifyContent:'space-between',marginTop:6,fontFamily:MONO,fontSize:9.5,color:sb}},h('span',{},'−90s'),h('span',{},'now'))),
      h('div',{style:{display:'flex',justifyContent:'space-between',alignItems:'center',margin:'18px 2px 10px'}},
        h('span',{style:{fontSize:14,fontWeight:700,color:tx,fontFamily:ff()}},t('dash_plants')),
        h('span',{style:{fontSize:12,color:dark?C.dPri:C.pri,fontWeight:600,fontFamily:ff()}},t('dash_viewall'))),
      h('div',{style:{display:'flex',flexDirection:'column',gap:10}},
        plant('Nam Theun 2','102.5',t('st_normal'),C.aBg,C.aTx,C.aGr),
        plant('Nam Ngum 1','88.3',t('st_normal'),C.aBg,C.aTx,C.aGr),
        plant('Houay Ho','0.0',t('st_maint'),C.cyBg,C.cyTx,C.cyTx),
        plant('Xeset 2','41.2',t('st_watch'),C.pBg,C.pTx,C.pGr))),
    navBar('dashboard',platform,dark,proto.go));
}

function scr_reports(platform, dark){
  const bg=dark?C.dBg:C.bg, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb;
  const rep=(date,plant,mwh,avail,water)=>h('div',{key:date,onClick:tap(()=>openDetail('reportDetail',{date,plant,mwh,avail,water})),style:{background:cd,borderRadius:14,padding:'13px 15px',border:`1px solid ${bd}`,cursor:cur()}},
    h('div',{style:{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:10}},
      h('div',{},h('div',{style:{fontSize:13,fontWeight:700,color:tx,fontFamily:ff()}},date),h('div',{style:{fontSize:11,color:sb,fontFamily:BF}},plant)),
      h('div',{style:{display:'flex',alignItems:'center',gap:8}},badge(avail+'%',avail>=98?C.aBg:C.pBg,avail>=98?C.aTx:C.pTx),ic('chevronR',16,sb,2))),
    h('div',{style:{display:'flex',gap:18}},
      h('div',{},h('div',{style:{fontSize:9.5,color:sb,fontFamily:ff(),marginBottom:2}},t('rep_energy')),h('div',{style:{fontSize:14,fontWeight:700,color:tx,fontFamily:NUM}},mwh,h('span',{style:{fontSize:10,color:sb}},' MWh'))),
      h('div',{},h('div',{style:{fontSize:9.5,color:sb,fontFamily:ff(),marginBottom:2}},t('rep_water')),h('div',{style:{fontSize:14,fontWeight:700,color:tx,fontFamily:NUM}},water,h('span',{style:{fontSize:10,color:sb}},' m')))));
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg}},
    header(platform,t('rep_title'),t('rep_sub'),{dark}),
    h('div',{style:{padding:'12px 16px 0'}},
      h('div',{style:{background:C.pBg,border:`1px solid ${C.pGr}44`,borderRadius:12,padding:'10px 13px',display:'flex',alignItems:'center',gap:10,marginBottom:12}},
        ic('wifiOff',18,C.pTx,1.8),
        h('div',{style:{flex:1}},h('div',{style:{fontSize:12,fontWeight:700,color:C.pTx,fontFamily:ff()}},t('off_title')),h('div',{style:{fontSize:10.5,color:C.pTx,opacity:0.85,fontFamily:ff()}},t('off_body'))),
        ic('refresh',18,C.pTx,1.8)),
      h('div',{style:{display:'flex',gap:8,marginBottom:14,flexWrap:'wrap'}},
        h('div',{onClick:tap(()=>proto.go('dateRange')),style:{display:'flex',alignItems:'center',gap:6,background:cd,border:`1.5px solid ${bd}`,borderRadius:20,padding:'7px 13px',cursor:cur()}},ic('filter',15,dark?C.dPri:C.pri,1.8),h('span',{style:{fontSize:12,fontWeight:600,color:tx,fontFamily:ff()}},'1–15 '+t('mabbr')+' '+t('year'))),
        h('div',{style:{display:'flex',alignItems:'center',gap:6,background:dark?C.dPri:C.pri,borderRadius:20,padding:'7px 13px'}},h('span',{style:{fontSize:12,fontWeight:700,color:'#fff',fontFamily:BF}},'Nam Theun 2'),ic('chevronD',14,'#fff',2)))),
    h('div',{style:{flex:1,overflow:'auto',padding:'0 16px 16px',display:'flex',flexDirection:'column',gap:10}},
      rep(repDate(15),'Nam Theun 2 Hydro','2,340',99,198.4),
      rep(repDate(14),'Nam Theun 2 Hydro','2,318',98,197.9),
      rep(repDate(13),'Nam Theun 2 Hydro','2,205',96,197.1),
      rep(repDate(12),'Nam Theun 2 Hydro','2,290',97,196.8)),
    navBar('reports',platform,dark,proto.go));
}

function scr_incident(platform, dark){
  const bg=dark?C.dBg:C.bg, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border;
  const sev=(t2,color,bgc,on)=>h('div',{key:t2,style:{flex:1,textAlign:'center',padding:'10px 4px',borderRadius:11,border:`1.5px solid ${on?color:bd}`,background:on?bgc:cd,color:on?color:sb,fontSize:11.5,fontWeight:700,fontFamily:ff()}},t2);
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg}},
    header(platform,t('inc_title'),t('inc_sub'),{dark,bell:false}),
    h('div',{style:{flex:1,overflow:'auto',padding:'16px'}},
      fieldRow(t('f_plant'),'Nam Theun 2 Hydro','water',dark,{trail:'chevronD'}),
      fieldInput('inc_title',t('f_title'),'wrench',dark,{preset:t('inc_title_val'),ph:'...'}),
      fieldInput('inc_desc',t('f_desc'),null,dark,{preset:t('inc_desc_val'),textarea:true,rows:3,ph:'...'}),
      h('div',{style:{marginBottom:14}},
        h('div',{style:{fontSize:12.5,fontWeight:600,color:tx,fontFamily:ff(),marginBottom:8}},t('inc_sev')),
        h('div',{style:{display:'flex',gap:8}},sev(t('sev_low'),C.aGr,C.aBg,false),sev(t('sev_med'),C.pGr,C.pBg,false),sev(t('sev_high'),'#C2410C','#FFEDD5',true),sev(t('sev_crit'),C.lRd,C.lBg,false))),
      h('div',{style:{marginBottom:14}},
        h('div',{style:{fontSize:12.5,fontWeight:600,color:tx,fontFamily:ff(),marginBottom:8}},t('inc_photo')),
        h('div',{onClick:tap(()=>proto.go('camera')),style:{cursor:cur()}},stripePlaceholder(t('inc_photo_hint'),96,dark))),
      h('div',{onClick:tap(()=>proto.go('gpsMap')),style:{display:'flex',alignItems:'center',gap:10,background:dark?C.dCard2:'#E1EEFB',borderRadius:12,padding:'11px 14px',marginBottom:20,cursor:cur()}},
        ic('pin',19,dark?C.dPri:C.cyTx,1.8),
        h('div',{style:{flex:1}},h('div',{style:{fontSize:12,fontWeight:700,color:dark?C.dTx:C.cyTx,fontFamily:ff()}},t('inc_gps')),h('div',{style:{fontSize:11,color:dark?C.dSb:C.cyTx,opacity:0.8,fontFamily:MONO}},'17.9757, 104.8461')),
        ic('checkCircle',18,C.aGr,2)),
      h('button',{onClick:tap(()=>proto.go('incidentDetail')),style:{width:'100%',background:'linear-gradient(135deg,#2E7BD6,#1A5CB0)',color:'#fff',border:'none',borderRadius:14,padding:'15px',fontSize:15,fontWeight:700,fontFamily:ff(),cursor:cur(),display:'flex',alignItems:'center',justifyContent:'center',gap:9,boxShadow:'0 6px 20px rgba(26,92,176,0.3)'}},ic('send',19,'#fff',2),t('inc_submit'))),
    navBar('incident',platform,dark,proto.go));
}

function scr_incidentDetail(platform, dark){
  const bg=dark?C.dBg:C.bg, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border;
  const step=(label,time,done,active,last)=>h('div',{key:label,style:{display:'flex',gap:12}},
    h('div',{style:{display:'flex',flexDirection:'column',alignItems:'center'}},
      h('div',{style:{width:24,height:24,borderRadius:'50%',background:done?C.aGr:(active?C.pri:(dark?C.dCard2:'#E4EBF5')),display:'flex',alignItems:'center',justifyContent:'center'}},done?ic('checkCircle',14,'#fff',2.4):h('span',{style:{width:8,height:8,borderRadius:'50%',background:active?'#fff':(dark?C.dSb:C.txSb)}})),
      last?null:h('div',{style:{width:2,flex:1,minHeight:26,background:done?C.aGr:(dark?C.dBorder:C.border)}})),
    h('div',{style:{paddingBottom:last?0:18}},
      h('div',{style:{fontSize:13,fontWeight:700,color:done||active?tx:sb,fontFamily:ff()}},label),
      time?h('div',{style:{fontSize:11,color:sb,fontFamily:MONO,marginTop:2}},time):null));
  const rows=[[t('det_plant'),'Nam Theun 2 Hydro'],[t('det_by'),t('det_reporter')],[t('det_time'),repDate(15)+' · 09:41'],[t('det_coord'),'17.9757, 104.8461']];
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg}},
    header(platform,t('inc_title_val'),'INC-2569-0018',{dark,back:true}),
    h('div',{style:{flex:1,overflow:'auto',padding:'16px'}},
      h('div',{style:{display:'flex',gap:8,marginBottom:14}},badge(t('critical'),C.lBg,C.lTx,C.lRd),badge(t('det_inprog'),C.cyBg,C.cyTx,C.cyTx)),
      stripePlaceholder(t('inc_photo'),150,dark),
      h('div',{style:{background:cd,borderRadius:14,padding:'14px 16px',border:`1px solid ${bd}`,margin:'14px 0'}},
        ...rows.map((r,i)=>h('div',{key:i,style:{display:'flex',justifyContent:'space-between',padding:'8px 0',borderTop:i>0?`1px solid ${bd}`:'none'}},
          h('span',{style:{fontSize:12.5,color:sb,fontFamily:ff()}},r[0]),
          h('span',{style:{fontSize:12.5,fontWeight:600,color:tx,fontFamily:i===3?MONO:ff()}},r[1])))),
      h('div',{style:{fontSize:13.5,color:tx,fontFamily:ff(),lineHeight:1.55,marginBottom:18}},t('det_desc')),
      h('div',{style:{fontSize:13,fontWeight:700,color:tx,fontFamily:ff(),marginBottom:14}},t('det_timeline')),
      step(t('tl_reported'),'09:41',true,false),
      step(t('tl_ack'),'09:52',true,false),
      step(t('tl_prog'),'10:15',false,true),
      step(t('tl_resolved'),'',false,false,true)),
    navBar('incident',platform,dark,proto.go));
}

function scr_meter(platform, dark){
  const bg=dark?C.dBg:C.bg, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border;
  const row=(code,kwh,hour,pending)=>h('div',{key:code+hour,onClick:tap(()=>openDetail('meterDetail',{code,kwh,hour,pending})),style:{background:cd,borderRadius:13,padding:'11px 13px',display:'flex',alignItems:'center',gap:11,border:`1px solid ${bd}`,cursor:cur()}},
    pending?ic('clock',20,C.pGr,1.8):ic('checkCircle',20,C.aGr,1.8),
    h('div',{style:{flex:1}},h('div',{style:{fontSize:13,fontWeight:700,color:tx,fontFamily:MONO}},code,h('span',{style:{fontFamily:NUM,color:sb,fontWeight:600}},'  '+kwh+' kWh')),h('div',{style:{fontSize:10.5,color:sb,fontFamily:ff()}},t('mtr_hourword')+' '+hour+':00')),
    pending?badge(t('mtr_pending'),C.pBg,C.pTx):badge(t('mtr_confirm'),C.aBg,C.aTx),
    ic('chevronR',16,sb,2));
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg}},
    header(platform,t('mtr_title'),t('mtr_sub'),{dark}),
    h('div',{style:{flex:1,overflow:'auto',padding:'16px'}},
      fieldInput('mtr_code',t('f_metercode'),'meter',dark,{preset:'MTR-0042',mono:true,ph:'MTR-0000'}),
      fieldInput('mtr_reading',t('f_reading'),'gauge',dark,{preset:'15,230.5',mono:true,type:'text',inputMode:'decimal',ph:'0.0'}),
      h('div',{style:{display:'flex',alignItems:'center',gap:10,background:dark?C.dCard2:'#E1EEFB',borderRadius:12,padding:'11px 14px',marginBottom:16}},
        ic('clock',18,dark?C.dPri:C.cyTx,1.8),h('span',{style:{fontSize:12.5,fontWeight:600,color:dark?C.dTx:C.cyTx,fontFamily:ff()}},t('mtr_hour'))),
      h('button',{style:{width:'100%',background:'linear-gradient(120deg,#F4B700,#D99C00)',color:'#3A2E00',border:'none',borderRadius:14,padding:'15px',fontSize:15,fontWeight:700,fontFamily:ff(),cursor:cur(),display:'flex',alignItems:'center',justifyContent:'center',gap:9,boxShadow:'0 6px 20px rgba(244,183,0,0.35)'}},ic('flash',19,'#3A2E00',2),t('mtr_save')),
      h('div',{style:{display:'flex',alignItems:'center',gap:10,margin:'22px 0 12px'}},
        h('span',{style:{fontSize:13,fontWeight:700,color:tx,fontFamily:ff()}},t('mtr_today')),
        h('div',{style:{flex:1,height:1,background:bd}})),
      h('div',{style:{display:'flex',flexDirection:'column',gap:9}},
        row('MTR-0042','15,230.5','14',true),
        row('MTR-0042','15,180.2','13',false),
        row('MTR-0041','8,942.0','13',false),
        row('MTR-0042','15,120.8','12',false))),
    navBar('meter',platform,dark,proto.go));
}

function scr_notifications(platform, dark){
  const bg=dark?C.dBg:C.bg, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border;
  const note=(iconName,iconBg,iconCol,title,body,time,unread,go)=>h('div',{key:title,onClick:go?tap(go):undefined,style:{background:cd,borderRadius:14,padding:'13px 14px',display:'flex',gap:12,border:`1px solid ${bd}`,position:'relative',cursor:proto.interactive&&go?'pointer':'default'}},
    h('div',{style:{width:42,height:42,borderRadius:12,background:iconBg,display:'flex',alignItems:'center',justifyContent:'center',flexShrink:0}},ic(iconName,21,iconCol,1.8)),
    h('div',{style:{flex:1,minWidth:0}},
      h('div',{style:{fontSize:13,fontWeight:700,color:tx,fontFamily:ff(),marginBottom:2}},title),
      h('div',{style:{fontSize:11.5,color:sb,fontFamily:ff(),lineHeight:1.45}},body),
      h('div',{style:{fontSize:10.5,color:sb,fontFamily:MONO,marginTop:5}},time)),
    unread?h('span',{style:{position:'absolute',top:14,right:14,width:9,height:9,borderRadius:'50%',background:C.pri}}):null);
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg}},
    header(platform,t('ntf_title'),t('ntf_sub'),{dark,bell:false}),
    h('div',{style:{flex:1,overflow:'auto',padding:'16px',display:'flex',flexDirection:'column',gap:10}},
      h('div',{style:{fontSize:11,fontWeight:700,color:sb,fontFamily:ff(),letterSpacing:'0.04em',textTransform:'uppercase',marginBottom:-2}},t('ntf_today')),
      note('alert',C.lBg,C.lRd,t('n1_t'),t('n1_b'),'09:41',true,()=>proto.go('incidentDetail')),
      note('checkCircle',C.aBg,C.aGr,t('n2_t'),t('n2_b'),'08:00',true),
      note('water',C.cyBg,C.cyTx,t('n3_t'),t('n3_b'),'07:30',true),
      h('div',{style:{fontSize:11,fontWeight:700,color:sb,fontFamily:ff(),letterSpacing:'0.04em',textTransform:'uppercase',margin:'8px 0 -2px'}},t('ntf_yesterday')),
      note('meter',C.pBg,C.pTx,t('n4_t'),t('n4_b'),'16:05',false),
      note('gauge',dark?C.dCard2:'#E1EEFB',dark?C.dPri:C.pri,t('n5_t'),t('n5_b'),'14:22',false)),
    navBar('profile',platform,dark,proto.go));
}

function scr_profile(platform, dark){
  const bg=dark?C.dBg:C.bg, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border;
  const sw=(on)=>h('div',{style:{width:44,height:26,borderRadius:20,background:on?C.pri:(dark?C.dBorder:C.border),position:'relative',flexShrink:0}},h('div',{style:{position:'absolute',top:3,left:on?21:3,width:20,height:20,borderRadius:'50%',background:'#fff',boxShadow:'0 1px 3px rgba(0,0,0,0.3)'}}));
  const item=(iconName,label,trail,last,go)=>h('div',{key:label,onClick:go?tap(go):undefined,style:{display:'flex',alignItems:'center',gap:13,padding:'13px 15px',borderTop:last?'none':`1px solid ${bd}`,cursor:proto.interactive&&go?'pointer':'default'}},
    h('div',{style:{width:34,height:34,borderRadius:10,background:dark?C.dCard2:'#E1EEFB',display:'flex',alignItems:'center',justifyContent:'center',flexShrink:0}},ic(iconName,18,dark?C.dPri:C.pri,1.7)),
    h('span',{style:{flex:1,fontSize:14,fontWeight:600,color:tx,fontFamily:ff()}},label),
    trail);
  const nextLang = proto.lang==='lo'?'th':proto.lang==='th'?'en':'lo';
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg}},
    header(platform,t('nav_profile'),t('prof_sub'),{dark,bell:false}),
    h('div',{style:{flex:1,overflow:'auto',padding:'16px'}},
      h('div',{style:{background:cd,borderRadius:16,padding:'18px',display:'flex',alignItems:'center',gap:14,border:`1px solid ${bd}`,marginBottom:16}},
        h('div',{style:{width:58,height:58,borderRadius:'50%',background:'linear-gradient(135deg,#2E7BD6,#1A5CB0)',display:'flex',alignItems:'center',justifyContent:'center',flexShrink:0}},h('span',{style:{color:'#fff',fontSize:22,fontWeight:700,fontFamily:NUM}},'SV')),
        h('div',{style:{flex:1}},
          h('div',{style:{fontSize:16,fontWeight:700,color:tx,fontFamily:ff()}},t('name')),
          h('div',{style:{fontSize:12,color:sb,fontFamily:ff()}},t('prof_role')),
          h('div',{style:{fontSize:11,color:sb,fontFamily:MONO,marginTop:2}},'engineer@edlgen.la')),
        ic('edit',18,dark?C.dPri:C.pri,1.7)),
      h('div',{style:{fontSize:11,fontWeight:700,color:sb,fontFamily:ff(),textTransform:'uppercase',letterSpacing:'0.04em',margin:'4px 4px 8px'}},t('prof_settings')),
      h('div',{style:{background:cd,borderRadius:14,border:`1px solid ${bd}`,overflow:'hidden',marginBottom:16}},
        item('globe',t('set_lang'),h('div',{style:{display:'flex',alignItems:'center',gap:6}},h('span',{style:{fontSize:13,color:dark?C.dPri:C.pri,fontWeight:700,fontFamily:ff()}},t('lang_name')),ic('chevronR',16,sb,2)),false,()=>proto.setLang(nextLang)),
        item('moon',t('set_dark'),sw(dark),false,()=>proto.toggleDark()),
        item('bell',t('set_notif'),sw(true)),
        item('info',t('set_about'),ic('chevronR',16,sb,2))),
      h('button',{onClick:tap(()=>proto.go('login')),style:{width:'100%',background:C.lBg,color:C.lRd,border:'none',borderRadius:14,padding:'14px',fontSize:14.5,fontWeight:700,fontFamily:ff(),cursor:cur(),display:'flex',alignItems:'center',justifyContent:'center',gap:9}},ic('logout',19,C.lRd,2),t('prof_logout')),
      h('div',{style:{textAlign:'center',fontSize:10.5,color:sb,fontFamily:MONO,marginTop:16}},'EDL-Gen Monitoring · v1.0.0')),
    navBar('profile',platform,dark,proto.go));
}

function scr_dateRange(platform, dark){
  const bg=dark?C.dBg:C.bg, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border;
  const wd = t('dr_wd');
  const offset=3; // Jul 1 2026 = Wednesday
  const cells=[]; for(let i=0;i<offset;i++) cells.push(null); for(let d=1;d<=31;d++) cells.push(d);
  const dayCell=(d)=>{
    if(d===null) return h('div',{key:'e'+Math.random()});
    const inRange = d>=1 && d<=15, isStart=d===1, isEnd=d===15;
    return h('div',{key:d,style:{aspectRatio:'1',display:'flex',alignItems:'center',justifyContent:'center',position:'relative'}},
      inRange?h('div',{style:{position:'absolute',inset:'3px 0',background:dark?'#12233a':'#E1EEFB',borderTopLeftRadius:isStart?20:0,borderBottomLeftRadius:isStart?20:0,borderTopRightRadius:isEnd?20:0,borderBottomRightRadius:isEnd?20:0}}):null,
      h('div',{style:{position:'relative',zIndex:1,width:34,height:34,borderRadius:'50%',display:'flex',alignItems:'center',justifyContent:'center',fontSize:14,fontFamily:NUM,fontWeight:(isStart||isEnd)?700:500,background:(isStart||isEnd)?'linear-gradient(135deg,#2E7BD6,#1A5CB0)':'transparent',color:(isStart||isEnd)?'#fff':(inRange?(dark?C.dPri:C.pri):tx)}},d));
  };
  const quick=(label,on)=>h('div',{key:label,style:{padding:'8px 15px',borderRadius:20,fontSize:12.5,fontWeight:700,fontFamily:ff(),cursor:cur(),border:`1.5px solid ${on?C.pri:bd}`,background:on?C.pri:cd,color:on?'#fff':sb}},label);
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg}},
    header(platform,t('dr_title'),t('dr_sub'),{dark,back:'reports'}),
    h('div',{style:{flex:1,overflow:'auto',padding:'16px'}},
      h('div',{style:{display:'flex',gap:10,marginBottom:18}},
        h('div',{style:{flex:1,background:cd,border:`1.5px solid ${C.pri}`,borderRadius:12,padding:'10px 13px'}},
          h('div',{style:{fontSize:10.5,color:sb,fontFamily:ff(),marginBottom:3}},t('dr_from')),
          h('div',{style:{fontSize:14,fontWeight:700,color:tx,fontFamily:NUM}},'01 '+t('mabbr')+' '+t('year'))),
        h('div',{style:{flex:1,background:cd,border:`1.5px solid ${bd}`,borderRadius:12,padding:'10px 13px'}},
          h('div',{style:{fontSize:10.5,color:sb,fontFamily:ff(),marginBottom:3}},t('dr_to')),
          h('div',{style:{fontSize:14,fontWeight:700,color:tx,fontFamily:NUM}},'15 '+t('mabbr')+' '+t('year')))),
      h('div',{style:{fontSize:12,fontWeight:700,color:sb,fontFamily:ff(),textTransform:'uppercase',letterSpacing:'0.04em',marginBottom:10}},t('dr_quick')),
      h('div',{style:{display:'flex',gap:8,marginBottom:22,flexWrap:'wrap'}},quick(t('dr_7'),false),quick(t('dr_30'),false),quick(t('dr_month'),true)),
      h('div',{style:{background:cd,borderRadius:16,border:`1px solid ${bd}`,padding:'16px 14px'}},
        h('div',{style:{display:'flex',alignItems:'center',justifyContent:'space-between',marginBottom:14}},
          ic('chevronL',18,sb,2),
          h('span',{style:{fontSize:14,fontWeight:700,color:tx,fontFamily:ff()}},t('month')+' '+t('year')),
          ic('chevronR',18,sb,2)),
        h('div',{style:{display:'grid',gridTemplateColumns:'repeat(7,1fr)',gap:2,marginBottom:6}},
          ...wd.map((w,i)=>h('div',{key:i,style:{textAlign:'center',fontSize:11,fontWeight:700,color:sb,fontFamily:ff(),padding:'4px 0'}},w))),
        h('div',{style:{display:'grid',gridTemplateColumns:'repeat(7,1fr)',gap:2}},...cells.map(dayCell)))),
    h('div',{style:{padding:'12px 16px',borderTop:`1px solid ${bd}`,background:cd}},
      h('button',{onClick:tap(()=>proto.go('reports')),style:{width:'100%',background:'linear-gradient(135deg,#2E7BD6,#1A5CB0)',color:'#fff',border:'none',borderRadius:14,padding:`14px 0 ${platform==='ios'?24:14}px`,fontSize:15,fontWeight:700,fontFamily:ff(),cursor:cur(),display:'flex',alignItems:'center',justifyContent:'center',gap:9,boxShadow:'0 6px 20px rgba(26,92,176,0.3)'}},ic('filter',18,'#fff',2),t('dr_apply'))));
}

function scr_camera(platform, dark){
  const corner=(pos)=>h('div',{key:pos,style:{position:'absolute',width:26,height:26,border:'3px solid rgba(255,255,255,0.9)',...pos}});
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:'#0A0A0C'}},
    h('div',{style:{paddingTop:statusPad(platform)+10,paddingBottom:12,paddingLeft:16,paddingRight:16,display:'flex',alignItems:'center',justifyContent:'space-between'}},
      h('div',{onClick:tap(()=>proto.go('incident')),style:{width:36,height:36,borderRadius:'50%',background:'rgba(255,255,255,0.14)',display:'flex',alignItems:'center',justifyContent:'center',cursor:cur()}},ic('chevronL',20,'#fff',2)),
      h('span',{style:{color:'#fff',fontSize:15,fontWeight:700,fontFamily:ff()}},t('cam_title')),
      h('div',{style:{width:36,height:36,borderRadius:'50%',background:'rgba(255,255,255,0.14)',display:'flex',alignItems:'center',justifyContent:'center'}},ic('flash',18,'#F4B700',1.9))),
    h('div',{style:{flex:1,position:'relative',margin:'8px 14px',borderRadius:20,overflow:'hidden',background:`repeating-linear-gradient(135deg,#15181F,#15181F 12px,#1B1F28 12px,#1B1F28 24px)`,display:'flex',flexDirection:'column',alignItems:'center',justifyContent:'center',gap:12}},
      corner({top:16,left:16,borderRight:'none',borderBottom:'none',borderTopLeftRadius:8}),
      corner({top:16,right:16,borderLeft:'none',borderBottom:'none',borderTopRightRadius:8}),
      corner({bottom:16,left:16,borderRight:'none',borderTop:'none',borderBottomLeftRadius:8}),
      corner({bottom:16,right:16,borderLeft:'none',borderTop:'none',borderBottomRightRadius:8}),
      h('div',{style:{width:64,height:64,borderRadius:18,background:'rgba(255,255,255,0.1)',display:'flex',alignItems:'center',justifyContent:'center'}},ic('wrench',30,'rgba(255,255,255,0.7)',1.6)),
      h('span',{style:{color:'rgba(255,255,255,0.7)',fontSize:12.5,fontFamily:ff()}},t('cam_hint')),
      h('div',{style:{position:'absolute',bottom:14,left:14,display:'flex',alignItems:'center',gap:6,background:'rgba(0,0,0,0.45)',borderRadius:20,padding:'5px 11px'}},ic('pin',13,'#F4B700',1.9),h('span',{style:{color:'#fff',fontSize:10.5,fontFamily:MONO}},'17.9757, 104.8461'))),
    h('div',{style:{display:'flex',alignItems:'center',justifyContent:'space-between',padding:`18px 34px ${platform==='ios'?34:22}px`}},
      h('div',{style:{display:'flex',flexDirection:'column',alignItems:'center',gap:5}},
        h('div',{style:{width:46,height:46,borderRadius:12,background:`repeating-linear-gradient(135deg,#2b2f3a,#2b2f3a 6px,#333845 6px,#333845 12px)`,border:'1px solid rgba(255,255,255,0.15)'}}),
        h('span',{style:{color:'rgba(255,255,255,0.6)',fontSize:9.5,fontFamily:ff()}},t('cam_gallery'))),
      h('div',{onClick:tap(()=>proto.go('incident')),style:{width:74,height:74,borderRadius:'50%',border:'4px solid rgba(255,255,255,0.9)',padding:4,cursor:cur()}},
        h('div',{style:{width:'100%',height:'100%',borderRadius:'50%',background:'#fff'}})),
      h('div',{style:{width:46,height:46,borderRadius:'50%',background:'rgba(255,255,255,0.12)',display:'flex',alignItems:'center',justifyContent:'center'}},ic('refresh',22,'#fff',1.9))));
}

function scr_gpsMap(platform, dark){
  const bg=dark?C.dBg:C.bg, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border;
  const mapBg = dark?'#0E1B2E':'#E8EEF6';
  const roadC = dark?'#1C3050':'#D2DEEC';
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg,position:'relative'}},
    header(platform,t('gps_title'),t('gps_sub'),{dark,back:'incident'}),
    h('div',{style:{flex:1,position:'relative',overflow:'hidden',background:mapBg}},
      // faux map: roads + river + plots
      h('svg',{viewBox:'0 0 390 500',width:'100%',height:'100%',preserveAspectRatio:'xMidYMid slice',style:{display:'block',position:'absolute',inset:0}},
        h('rect',{x:0,y:0,width:390,height:500,fill:mapBg}),
        h('path',{d:'M-20 120 L200 180 L420 90',stroke:roadC,strokeWidth:14,fill:'none'}),
        h('path',{d:'M60 -20 L150 250 L120 520',stroke:roadC,strokeWidth:10,fill:'none'}),
        h('path',{d:'M-20 360 L200 320 L420 400',stroke:roadC,strokeWidth:12,fill:'none'}),
        h('path',{d:'M300 -20 C260 150 340 300 300 520',stroke:dark?'#153a52':'#BEDDF0',strokeWidth:26,fill:'none',opacity:0.9}),
        h('circle',{cx:230,cy:150,r:34,fill:dark?'#12233a':'#DCE7F4'}),
        h('circle',{cx:95,cy:400,r:26,fill:dark?'#12233a':'#DCE7F4'})),
      // accuracy halo + marker (center)
      h('div',{style:{position:'absolute',left:'50%',top:'46%',transform:'translate(-50%,-50%)',width:120,height:120,borderRadius:'50%',background:'rgba(26,92,176,0.15)',border:'1px solid rgba(26,92,176,0.3)'}}),
      h('div',{style:{position:'absolute',left:'50%',top:'46%',transform:'translate(-50%,-100%)',display:'flex',flexDirection:'column',alignItems:'center'}},
        h('div',{style:{width:44,height:44,borderRadius:'50%',background:C.lRd,display:'flex',alignItems:'center',justifyContent:'center',boxShadow:'0 6px 16px rgba(216,35,42,0.45)',border:'3px solid #fff'}},ic('wrench',22,'#fff',1.9)),
        h('div',{style:{width:3,height:14,background:C.lRd}})),
      // plant label chip
      h('div',{style:{position:'absolute',left:'50%',top:'56%',transform:'translateX(-50%)',background:cd,borderRadius:20,padding:'5px 12px',boxShadow:'0 3px 10px rgba(0,0,0,0.15)',display:'flex',alignItems:'center',gap:6}},
        ic('water',13,dark?C.dPri:C.pri,1.9),h('span',{style:{fontSize:11,fontWeight:700,color:tx,fontFamily:BF}},'Nam Theun 2'))),
    // bottom sheet
    h('div',{style:{background:cd,borderTopLeftRadius:22,borderTopRightRadius:22,marginTop:-18,padding:'18px 18px '+(platform==='ios'?'26px':'16px'),boxShadow:'0 -8px 24px rgba(0,0,0,0.1)',position:'relative',zIndex:2}},
      h('div',{style:{display:'flex',alignItems:'flex-start',gap:12,marginBottom:14}},
        h('div',{style:{width:42,height:42,borderRadius:12,background:dark?C.dCard2:'#E1EEFB',display:'flex',alignItems:'center',justifyContent:'center',flexShrink:0}},ic('pin',22,dark?C.dPri:C.pri,1.8)),
        h('div',{style:{flex:1}},
          h('div',{style:{fontSize:14,fontWeight:700,color:tx,fontFamily:ff()}},t('gps_current')),
          h('div',{style:{fontSize:12.5,color:dark?C.dPri:C.pri,fontFamily:MONO,margin:'2px 0'}},'17.9757, 104.8461'),
          h('div',{style:{display:'flex',gap:14,marginTop:4}},
            h('span',{style:{fontSize:11,color:sb,fontFamily:ff()}},t('gps_accuracy')),
            h('span',{style:{fontSize:11,color:sb,fontFamily:ff()}},t('gps_plant')))),
        badge('GPS',C.aBg,C.aTx,C.aGr)),
      h('button',{onClick:tap(()=>proto.go('incident')),style:{width:'100%',background:'linear-gradient(135deg,#2E7BD6,#1A5CB0)',color:'#fff',border:'none',borderRadius:14,padding:'14px',fontSize:15,fontWeight:700,fontFamily:ff(),cursor:cur(),display:'flex',alignItems:'center',justifyContent:'center',gap:9,boxShadow:'0 6px 20px rgba(26,92,176,0.3)'}},ic('checkCircle',18,'#fff',2),t('gps_use'))));
}

function statRow(items, dark){
  const tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border;
  return h('div',{style:{display:'flex',gap:10}},...items.map((s,i)=>h('div',{key:i,style:{flex:1,background:cd,borderRadius:14,padding:'12px 14px',border:`1px solid ${bd}`}},
    h('div',{style:{fontSize:10.5,color:sb,fontFamily:ff(),marginBottom:5}},s[0]),
    h('div',{style:{display:'flex',alignItems:'baseline',gap:3}},h('span',{style:{fontSize:20,fontWeight:700,color:tx,fontFamily:NUM}},s[1]),h('span',{style:{fontSize:11,color:sb,fontWeight:600}},s[2])))));
}
function scr_plantDetail(platform, dark){
  const bg=dark?C.dBg:C.bg, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border;
  const d=proto.detail||{}; const name=d.name||'Nam Theun 2'; const mw=d.mw||'102.5';
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg}},
    header(platform,name,'Hydro · EDL-Gen',{dark,back:'dashboard'}),
    h('div',{style:{flex:1,overflow:'auto',padding:'16px'}},
      h('div',{style:{background:'linear-gradient(140deg,#2E7BD6,#1A5CB0 55%,#0E3B78)',borderRadius:18,padding:16,marginBottom:14,position:'relative',overflow:'hidden'}},
        h('div',{style:{position:'absolute',right:-16,top:-16,width:90,height:90,borderRadius:'50%',background:'rgba(255,255,255,0.06)'}}),
        h('div',{style:{position:'relative',zIndex:1}},
          h('div',{style:{display:'flex',justifyContent:'space-between',alignItems:'center'}},
            h('span',{style:{color:'rgba(255,255,255,0.7)',fontSize:11.5,fontFamily:ff()}},t('pd_output')),badge(d.st||t('st_normal'),d.stBg||C.aBg,d.stTx||C.aTx,d.dot||C.aGr)),
          h('div',{style:{display:'flex',alignItems:'baseline',gap:6,margin:'8px 0 2px'}},h('span',{style:{color:'#fff',fontSize:34,fontWeight:700,fontFamily:NUM}},mw),h('span',{style:{color:C.gold,fontSize:16,fontWeight:700}},'MW')),
          h('div',{style:{color:'rgba(255,255,255,0.6)',fontSize:11,fontFamily:ff()}},t('pd_updated')))),
      h('div',{style:{marginBottom:14}},statRow([[t('dash_freq'),'50.02','Hz'],[t('dash_volt'),'22.87','kV'],[t('dash_water'),'198.4','m']],dark)),
      h('div',{style:{marginBottom:14}},statRow([[t('pd_energy_today'),'2,340','MWh'],[t('pd_uptime'),'98.6','%']],dark)),
      h('div',{style:{background:cd,borderRadius:16,padding:14,border:`1px solid ${bd}`}},
        h('div',{style:{display:'flex',justifyContent:'space-between',alignItems:'center',marginBottom:10}},h('span',{style:{fontSize:12.5,fontWeight:700,color:tx,fontFamily:ff()}},t('dash_chart')),badge('MW',dark?'#12233a':'#E1EEFB',dark?C.dPri:C.cyTx)),
        miniChart(dark),
        h('div',{style:{display:'flex',justifyContent:'space-between',marginTop:6,fontFamily:MONO,fontSize:9.5,color:sb}},h('span',{},'−90s'),h('span',{},'now')))),
    navBar('dashboard',platform,dark,proto.go));
}
function scr_reportDetail(platform, dark){
  const bg=dark?C.dBg:C.bg, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border;
  const d=proto.detail||{}; const date=d.date||repDate(15); const mwh=d.mwh||'2,340'; const avail=d.avail||99; const water=d.water||198.4;
  const bars=[70,82,88,92,96,90,84,78,86,94,98,88];
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg}},
    header(platform,date,d.plant||'Nam Theun 2 Hydro',{dark,back:'reports'}),
    h('div',{style:{flex:1,overflow:'auto',padding:'16px'}},
      h('div',{style:{marginBottom:14}},statRow([[t('rep_energy'),mwh,'MWh'],[t('rd_peak'),'112.4','MW']],dark)),
      h('div',{style:{marginBottom:14}},statRow([[t('pd_uptime'),avail,'%'],[t('rep_water'),water,'m']],dark)),
      h('div',{style:{background:cd,borderRadius:16,padding:14,border:`1px solid ${bd}`}},
        h('div',{style:{fontSize:12.5,fontWeight:700,color:tx,fontFamily:ff(),marginBottom:12}},t('rd_hourly')),
        h('div',{style:{display:'flex',alignItems:'flex-end',gap:5,height:110}},
          ...bars.map((v,i)=>h('div',{key:i,style:{flex:1,display:'flex',flexDirection:'column',alignItems:'center',gap:5}},
            h('div',{style:{width:'100%',height:v+'%',borderRadius:5,background:'linear-gradient(180deg,#2E7BD6,#1A5CB0)'}}),
            h('span',{style:{fontSize:8,color:sb,fontFamily:MONO}},(i*2)+'')))),
        h('div',{style:{fontSize:9.5,color:sb,fontFamily:MONO,textAlign:'center',marginTop:6}},'ຊົ່ວໂມງ · hour (00–24)'))),
    navBar('reports',platform,dark,proto.go));
}
function scr_meterDetail(platform, dark){
  const bg=dark?C.dBg:C.bg, tx=dark?C.dTx:C.txDk, sb=dark?C.dSb:C.txSb, cd=dark?C.dCard:C.card, bd=dark?C.dBorder:C.border;
  const d=proto.detail||{}; const code=d.code||'MTR-0042'; const kwh=d.kwh||'15,230.5'; const hour=d.hour||'14'; const pending=d.pending;
  const rowKV=(label,val,mono,last)=>h('div',{key:label,style:{display:'flex',justifyContent:'space-between',padding:'11px 0',borderTop:last?'none':`1px solid ${bd}`}},
    h('span',{style:{fontSize:13,color:sb,fontFamily:ff()}},label),h('span',{style:{fontSize:13,fontWeight:700,color:tx,fontFamily:mono?MONO:ff()}},val));
  return h('div',{style:{height:'100%',display:'flex',flexDirection:'column',background:bg}},
    header(platform,code,'Meter · Nam Theun 2',{dark,back:'meter'}),
    h('div',{style:{flex:1,overflow:'auto',padding:'16px'}},
      h('div',{style:{background:cd,borderRadius:16,padding:'20px 18px',border:`1px solid ${bd}`,textAlign:'center',marginBottom:16}},
        h('div',{style:{fontSize:11,color:sb,fontFamily:ff(),marginBottom:6}},t('md_reading')),
        h('div',{style:{display:'flex',alignItems:'baseline',justifyContent:'center',gap:6}},h('span',{style:{fontSize:36,fontWeight:700,color:tx,fontFamily:NUM}},kwh),h('span',{style:{fontSize:15,color:sb,fontWeight:700}},'kWh')),
        h('div',{style:{marginTop:12}},pending?badge(t('mtr_pending'),C.pBg,C.pTx,C.pGr):badge(t('mtr_confirm'),C.aBg,C.aTx,C.aGr))),
      h('div',{style:{background:cd,borderRadius:14,padding:'4px 16px',border:`1px solid ${bd}`}},
        rowKV(t('md_meter'),code,true,true),
        rowKV(t('md_time'),t('mtr_hourword')+' '+hour+':00'),
        rowKV(t('md_prev'),'15,180.2 kWh',true),
        rowKV(t('md_diff'),'+50.3 kWh',true),
        rowKV(t('md_by'),t('name')),
        rowKV(t('det_status'),pending?t('mtr_pending'):t('mtr_confirm')))),
    navBar('meter',platform,dark,proto.go));
}

function scr_forgot(platform, dark){
  return h('div',{style:{height:'100%',background:C.card,display:'flex',flexDirection:'column',overflow:'auto'}},
    h('div',{style:{paddingTop:statusPad(platform)+30,paddingBottom:24,background:'linear-gradient(165deg,#2E7BD6,#1A5CB0 60%,#0E3B78)',display:'flex',flexDirection:'column',alignItems:'center',position:'relative'}},
      h('div',{onClick:tap(()=>proto.go('login')),style:{position:'absolute',left:14,top:statusPad(platform)+18,width:36,height:36,borderRadius:11,background:'rgba(255,255,255,0.16)',display:'flex',alignItems:'center',justifyContent:'center',cursor:cur()}},ic('chevronL',20,'#fff',2)),
      h('div',{style:{width:66,height:66,borderRadius:'50%',background:'rgba(255,255,255,0.16)',display:'flex',alignItems:'center',justifyContent:'center'}},ic('lock',30,'#fff',1.8)),
      h('div',{style:{color:'#fff',fontSize:19,fontWeight:700,fontFamily:ff(),marginTop:14}},t('fp_title'))),
    h('div',{style:{padding:'26px 22px 18px',flex:1}},
      h('div',{style:{fontSize:13.5,color:C.txMd,fontFamily:ff(),lineHeight:1.55,marginBottom:22}},t('fp_desc')),
      fieldInput('fp_email',t('f_email'),'mail',false,{preset:'engineer@edlgen.la',type:'email',inputMode:'email',ph:'name@edlgen.la'}),
      h('button',{onClick:tap(()=>proto.go('login')),style:{width:'100%',background:'linear-gradient(135deg,#2E7BD6,#1A5CB0)',color:'#fff',border:'none',borderRadius:14,padding:'15px',fontSize:15.5,fontWeight:700,fontFamily:ff(),cursor:cur(),display:'flex',alignItems:'center',justifyContent:'center',gap:9,boxShadow:'0 6px 22px rgba(26,92,176,0.32)',marginTop:4}},ic('mail',19,'#fff',2),t('fp_send')),
      h('div',{style:{display:'flex',alignItems:'center',gap:8,background:C.cyBg,borderRadius:12,padding:'11px 14px',marginTop:16}},ic('clock',17,C.cyTx,1.8),h('span',{style:{fontSize:12,color:C.cyTx,fontFamily:ff()}},t('fp_note'))),
      h('div',{onClick:tap(()=>proto.go('login')),style:{textAlign:'center',marginTop:22,cursor:cur()}},h('span',{style:{fontSize:13,color:C.pri,fontWeight:700,fontFamily:ff()}},t('fp_back')))));
}

const SCREENS = {
  splash:scr_splash, login:scr_login, dashboard:scr_dashboard, reports:scr_reports,
  incident:scr_incident, incidentDetail:scr_incidentDetail, meter:scr_meter,
  notifications:scr_notifications, profile:scr_profile,
  dateRange:scr_dateRange, camera:scr_camera, gpsMap:scr_gpsMap,
  plantDetail:scr_plantDetail, reportDetail:scr_reportDetail, meterDetail:scr_meterDetail,
  forgot:scr_forgot,
};

function Phone({screen, platform, dark}){
  const Dev = platform==='ios'? window.IOSDevice : window.AndroidDevice;
  const content = SCREENS[screen](platform, dark);
  const w = platform==='ios'?390:412;
  const ht = platform==='ios'?844:892;
  return h(Dev,{dark:!!dark, width:w, height:ht}, h('div',{style:{height:'100%',fontFamily:BF}}, content));
}

function Pair({screen, dark, label, en}){
  return h('div',{style:{display:'flex',flexDirection:'column',gap:14,scrollMarginTop:16}},
    h('div',{style:{display:'flex',alignItems:'baseline',gap:10}},
      h('span',{style:{fontSize:15,fontWeight:700,color:'#152641',fontFamily:LAO}},label),
      h('span',{style:{fontSize:12,color:'#7C8CA8',fontFamily:NUM}},en)),
    h('div',{style:{display:'flex',gap:22,alignItems:'flex-start'}},
      h('div',{style:{display:'flex',flexDirection:'column',gap:8,alignItems:'center'}},
        h('span',{style:{fontSize:10.5,fontWeight:700,color:'#7C8CA8',fontFamily:MONO,letterSpacing:'0.04em'}},'iOS · iPhone'),
        h(Phone,{screen,platform:'ios',dark})),
      h('div',{style:{display:'flex',flexDirection:'column',gap:8,alignItems:'center'}},
        h('span',{style:{fontSize:10.5,fontWeight:700,color:'#7C8CA8',fontFamily:MONO,letterSpacing:'0.04em'}},'Android · Pixel'),
        h(Phone,{screen,platform:'android',dark}))));
}

function EDLBoard(){
  proto.interactive = false; proto.lang='lo';
  const groups=[
    {screen:'splash',label:'Splash',en:'ໜ້າເປີດ'},
    {screen:'login',label:'ເຂົ້າສູ່ລະບົບ',en:'Login · 3 languages'},
    {screen:'dashboard',label:'ໜ້າຫຼັກ Dashboard',en:'Real-time · Light'},
    {screen:'dashboard',dark:true,label:'Dashboard ໂໝດມືດ',en:'Real-time · Dark'},
    {screen:'reports',label:'ບົດລາຍງານປະຈຳວັນ',en:'Daily reports · Offline'},
    {screen:'incident',label:'ແຈ້ງເຫດຂັດຂ້ອງ',en:'Incident form · photo + GPS'},
    {screen:'incidentDetail',label:'ລາຍລະອຽດເຫດ',en:'Incident detail · timeline'},
    {screen:'meter',label:'ຈົດຄ່າມິເຕີ',en:'Meter · optimistic list'},
    {screen:'notifications',label:'ການແຈ້ງເຕືອນ',en:'Notifications'},
    {screen:'profile',label:'ໂປຣໄຟລ໌ & ຕັ້ງຄ່າ',en:'Profile · language switch'},
  ];
  return h('div',{style:{padding:'36px 44px 80px',display:'flex',flexWrap:'wrap',gap:'48px 56px',alignItems:'flex-start',background:'#F0F4FA',minHeight:'100vh'}},
    ...groups.map((g,i)=>h(Pair,{key:i,...g})));
}
window.EDLBoard = EDLBoard;

// ─── Interactive clickable prototype ───
function EDLPrototype(){
  const [screen,setScreen] = useState('splash');
  const [dark,setDark] = useState(false);
  const [lang,setLang] = useState('lo');
  const [platform,setPlatform] = useState('both');
  proto.go = (s)=>setScreen(s);
  proto.toggleDark = ()=>setDark(d=>!d);
  proto.setLang = (l)=>setLang(l);
  proto.dark = dark; proto.lang = lang; proto.interactive = true;

  const TABS = [['splash',t('tab_splash')],['login',t('tab_login')],['forgot',t('tab_forgot')],['dashboard',t('tab_dash')],['reports',t('tab_reports')],['dateRange',t('tab_date')],['incident',t('tab_incident')],['camera',t('tab_camera')],['gpsMap',t('tab_gps')],['incidentDetail',t('tab_detail')],['meter',t('tab_meter')],['notifications',t('tab_notif')],['profile',t('tab_profile')]];
  const chip=(key,label)=>{const on=key===screen;return h('button',{key,onClick:()=>setScreen(key),style:{border:'none',cursor:'pointer',fontFamily:ff(),fontSize:12.5,fontWeight:on?700:600,padding:'8px 15px',borderRadius:20,background:on?'linear-gradient(135deg,#2E7BD6,#1A5CB0)':'#fff',color:on?'#fff':C.txMd,boxShadow:on?'0 3px 12px rgba(26,92,176,0.3)':'0 1px 3px rgba(26,92,176,0.08)'}},label);};
  const langBtn=(code,label,fam)=>{const on=code===lang;return h('button',{key:code,onClick:()=>setLang(code),style:{border:'none',cursor:'pointer',fontFamily:fam,fontSize:12,fontWeight:700,padding:'6px 13px',borderRadius:16,background:on?C.pri:'transparent',color:on?'#fff':C.txSb}},label);};
  const segBtn=(key,label)=>{const on=key===platform;return h('button',{key,onClick:()=>setPlatform(key),style:{border:'none',cursor:'pointer',fontFamily:BF,fontSize:11.5,fontWeight:700,padding:'6px 12px',borderRadius:16,background:on?C.pri:'transparent',color:on?'#fff':C.txSb}},label);};
  const showIos = platform!=='android', showAnd = platform!=='ios';
  return h('div',{style:{minHeight:'100vh',background:'#F0F4FA',fontFamily:BF}},
    h('div',{style:{position:'sticky',top:0,zIndex:30,background:'rgba(240,244,250,0.92)',backdropFilter:'blur(10px)',borderBottom:`1px solid ${C.border}`,padding:'14px 32px 12px'}},
      h('div',{style:{display:'flex',alignItems:'center',gap:14,marginBottom:12,flexWrap:'wrap'}},
        h('div',{style:{background:'#fff',borderRadius:'50%',padding:4,boxShadow:'0 2px 10px rgba(26,92,176,0.15)'}},h('img',{src:'assets/edl-gen-logo.jfif',style:{width:34,height:34,borderRadius:'50%',display:'block',objectFit:'contain'}})),
        h('div',{style:{flex:1,minWidth:180}},
          h('div',{style:{fontSize:17,fontWeight:700,color:C.txDk}},'EDL-Gen Monitoring — Prototype'),
          h('div',{style:{fontSize:11.5,color:C.txSb,fontFamily:ff()}},t('proto_sub'))),
        h('div',{style:{display:'flex',background:'#fff',borderRadius:18,padding:3,boxShadow:'0 1px 3px rgba(26,92,176,0.1)'}},langBtn('lo','ລາວ',LAO),langBtn('th','ไทย',TH),langBtn('en','EN',NUM)),
        h('div',{style:{display:'flex',background:'#fff',borderRadius:18,padding:3,boxShadow:'0 1px 3px rgba(26,92,176,0.1)'}},segBtn('both','⬛⬛'),segBtn('ios','iOS'),segBtn('android','Android')),
        h('button',{onClick:()=>setDark(d=>!d),style:{display:'flex',alignItems:'center',gap:7,border:`1.5px solid ${C.border}`,cursor:'pointer',fontFamily:BF,fontSize:12,fontWeight:700,padding:'7px 14px',borderRadius:18,background:dark?C.txDk:'#fff',color:dark?'#fff':C.txMd}},ic('moon',16,dark?C.gold:C.pri,1.8),dark?'Dark':'Light')),
      h('div',{style:{display:'flex',gap:8,flexWrap:'wrap'}},...TABS.map(x=>chip(x[0],x[1])))),
    h('div',{style:{display:'flex',gap:34,justifyContent:'center',alignItems:'flex-start',padding:'34px 24px 70px'}},
      showIos?h('div',{style:{display:'flex',flexDirection:'column',gap:10,alignItems:'center'}},
        h('span',{style:{fontSize:11,fontWeight:700,color:C.txSb,fontFamily:MONO,letterSpacing:'0.04em'}},'iOS · iPhone'),
        h(Phone,{screen,platform:'ios',dark})):null,
      showAnd?h('div',{style:{display:'flex',flexDirection:'column',gap:10,alignItems:'center'}},
        h('span',{style:{fontSize:11,fontWeight:700,color:C.txSb,fontFamily:MONO,letterSpacing:'0.04em'}},'Android · Pixel'),
        h(Phone,{screen,platform:'android',dark})):null));
}
window.EDLPrototype = EDLPrototype;

module.exports = { EDLBoard, EDLPrototype };
