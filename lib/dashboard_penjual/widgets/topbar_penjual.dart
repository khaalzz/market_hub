import 'package:flutter/material.dart';

class TopbarPenjual extends StatelessWidget {
  const TopbarPenjual({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        color: Color(0xff111827),
        border: Border(
          bottom: BorderSide(color: Color(0xff1f2933)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'MARKETHUB Seller Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Row(
            children: const [
              Icon(
                Icons.devices_outlined,
                color: Colors.white70,
                size: 18,
              ),
              SizedBox(width: 6),
              Text(
                'Device',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.expand_more,
                color: Colors.white70,
                size: 18,
              ),
            ],
          )
        ],
      ),
    );
  }
}
