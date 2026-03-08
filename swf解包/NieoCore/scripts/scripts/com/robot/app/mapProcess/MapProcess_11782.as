package com.robot.app.mapProcess
{
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11782 extends BaseMapProcess
   {
      
      private var temp:int;
      
      private var temp1:int;
      
      private var temp2:int;
      
      private var m_state:int;
      
      private var m_count:int;
      
      private var m_curMap:int;
      
      private var m_BossIndex:int;
      
      private var m_BoxCount:int;
      
      private var m_BoxBit:int;
      
      private var m_mapBit:int;
      
      private var totalNum:int;
      
      private var hasNum:int;
      
      private var lastPos:Point;
      
      private var objP:Point;
      
      private var objP1:Point;
      
      private var initPos:Point;
      
      public function MapProcess_11782()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         MainManager.actorInfo.mapID = 11782;
         this.initPos = new Point(475,363);
         MainManager.actorModel.pos = this.initPos.clone();
         depthLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         this.update();
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
      }
      
      public function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([10579,10581,10584,10582,10583],function(param1:Array):void
         {
            var _loc3_:int = 0;
            temp = param1[0] >> 8;
            m_mapBit = param1[0];
            m_state = temp & 0x0F;
            temp1 = param1[0] >> 12;
            m_curMap = temp1 & 0x0F;
            m_count = param1[1];
            m_BossIndex = param1[2];
            temp2 = param1[3] >> m_curMap * 4 - 4;
            m_BoxCount = temp2 & 0x0F;
            m_BoxBit = param1[4];
            if(m_BoxCount != 5)
            {
               _loc3_ = m_BoxCount + 1;
               while(_loc3_ <= 5)
               {
                  depthLevel["box_" + _loc3_].visible = false;
                  _loc3_++;
               }
            }
            var _loc2_:int = 16;
            while(_loc2_ <= 20)
            {
               if(KTool.getBit(m_BoxBit,_loc2_) == 1)
               {
                  depthLevel["box_" + (_loc2_ - 15)].visible = false;
               }
               _loc2_++;
            }
            depthLevel["panel"]["count"].text = m_count;
            if(m_count < 60)
            {
               depthLevel["panel"]["mc1"].gotoAndStop(5);
            }
            else if(m_count >= 60 && m_count <= 75)
            {
               depthLevel["panel"]["mc1"].gotoAndStop(1);
            }
            else if(m_count > 75 && m_count <= 110)
            {
               depthLevel["panel"]["mc1"].gotoAndStop(2);
            }
            else if(m_count > 110 && m_count <= 150)
            {
               depthLevel["panel"]["mc1"].gotoAndStop(3);
            }
            else
            {
               depthLevel["panel"]["mc1"].gotoAndStop(4);
            }
            if(m_state == 0)
            {
               depthLevel["panel"]["mc2"].visible = false;
            }
            else if(m_state == 1)
            {
               depthLevel["panel"]["mc2"].gotoAndStop(2);
            }
            else
            {
               depthLevel["panel"]["mc2"].gotoAndStop(1);
            }
         });
      }
      
      private function playAnimation() : void
      {
         SocketConnection.sendByQueue(43305,[19,6],function(param1:*):void
         {
            update();
         });
      }
      
      private function stopPlaying1() : void
      {
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var index:int = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "bag":
               PetBagControllerNew.showByBuffer();
               break;
            case "cure":
               PetManager.cureAllFree();
               break;
            case "box_" + index:
               StatManager.sendStat2014("1221圣诞主题活动","在地图内点击礼包","2018运营活动");
               if(this.m_state == 2)
               {
                  Alarm.show("麋鹿因为生病非常虚弱，请先安抚麋鹿在继续操作");
                  break;
               }
               if(this.m_count < 60)
               {
                  Alarm.show("麋鹿的心情糟糕透了，无法继续打开礼物了！");
                  break;
               }
               SocketConnection.sendByQueue(43306,[4,index],function(param1:*):void
               {
                  update();
                  if(m_count > 150)
                  {
                     ModuleManager.showAppModule("ChristmasThemeS5Panel");
                  }
                  else
                  {
                     ModuleManager.showAppModule("ChristmasThemeS4Panel");
                  }
               });
               break;
            case "go":
               ModuleManager.showAppModule("ChristmasThemeS3Panel");
               break;
            case "close":
               KTool.changeMapWithCallBack(11785,function():void
               {
                  ModuleManager.showAppModule("ChristmasThemeS3Panel");
               });
               break;
            case "milu":
               KTool.changeMapWithCallBack(11785,function():void
               {
                  ModuleManager.showAppModule("ChristmasThemeAppeasePanel");
               });
         }
      }
      
      private function stopPlaying() : void
      {
      }
      
      public function onWalkEnter(param1:RobotEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Number = NaN;
         _loc2_ = MainManager.actorModel.pos;
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         depthLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         ToolBarController.panel.visible = true;
      }
   }
}

