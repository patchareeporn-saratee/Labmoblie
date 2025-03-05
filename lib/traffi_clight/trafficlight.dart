import 'package:flutter/material.dart';
import 'dart:async';

class TrafficLightScreen extends StatefulWidget {
  @override
  _TrafficLightScreenState createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  int _currentLight = 0; // 0 = Red, 1 = Yellow, 2 = Green
  int _timeLeft = 10; // ตั้งค่าเวลาถอยหลังเริ่มต้น
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 1) {
          _timeLeft--;
        } else {
          _changeLight();
        }
      });
    });
  }

  void _changeLight() {
    setState(() {
      _currentLight = (_currentLight + 1) % 3;
      _timeLeft = (_currentLight == 1) ? 3 : (_currentLight == 0 ? 10 : 7);
    });
  }

  void _resetLights() {
    setState(() {
      _currentLight = 0;  // รีเซ็ตไฟเป็นแดง
      _timeLeft = 10;     // รีเซ็ตเวลาถอยหลังเป็น 10 วินาที
    });
    _startTimer();   // เริ่มต้นตัวจับเวลาใหม่
  }

  void _toggleLight(int lightIndex) {
    setState(() {
      if (_currentLight == lightIndex) {
        
        _currentLight = -1; 
      } else {
        _currentLight = lightIndex;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Traffic Light')),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Text(
              '$_timeLeft วินาที',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildTrafficLights(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeLight, // ปุ่มเปลี่ยนไฟ
              child: Text('เปลี่ยนไฟ'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 211, 209, 209),
                minimumSize: Size(130, 50), 
                textStyle: TextStyle(fontSize: 18), 
              ),
            ),
            SizedBox(height: 25),
            IconButton(
              onPressed: _resetLights,  // ปุ่มลูกศรวน
              icon: Icon(Icons.refresh),
              iconSize: 25,
              color: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrafficLights() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLight(Colors.redAccent, _currentLight == 0, 0),  // เปลี่ยนไฟแดง
          SizedBox(height: 10),
          _buildLight(Colors.amberAccent, _currentLight == 1, 1),  // เปลี่ยนไฟเหลือง
          SizedBox(height: 10),
          _buildLight(const Color.fromARGB(255, 73, 250, 60), _currentLight == 2, 2),  // เปลี่ยนไฟเขียว
        ],
      ),
    );
  }

  Widget _buildLight(Color color, bool isActive, int lightIndex) {
    return GestureDetector(
      onTap: () => _toggleLight(lightIndex), 
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          border: Border.all(color: const Color.fromARGB(255, 255, 252, 252), width: 3),
          boxShadow: [
            BoxShadow(
              color: isActive ? color.withOpacity(0.9) : Colors.transparent,
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: isActive ? 90 : 90,
            height: isActive ? 90 : 90,
            decoration: BoxDecoration(
              color: color.withOpacity(isActive ? 1.0 : 0.4),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
