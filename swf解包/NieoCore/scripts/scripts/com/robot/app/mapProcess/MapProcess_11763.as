package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.npc.NpcDialogNew_1;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11763 extends BaseMapProcess
   {
      
      private var m_value:int;
      
      private var totalNum:int;
      
      private var hasNum:int;
      
      private var lastPos:Point;
      
      private var objP:Point;
      
      private var objP1:Point;
      
      private var initPos:Point;
      
      public function MapProcess_11763()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = true;
         MainManager.actorInfo.mapID = 11763;
         depthLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick1);
         this.initPos = new Point(793,107);
         this.objP = new Point();
         this.objP1 = new Point();
         this.objP.x = conLevel["door_1"].x;
         this.objP.y = conLevel["door_1"].y;
         this.objP1.x = conLevel["door_2"].x;
         this.objP1.y = conLevel["door_2"].y;
         MainManager.actorModel.pos = this.initPos.clone();
         this.update();
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         if(BitBuffSetClass.getState(23702) == 0)
         {
            this.playAnimation();
            BitBuffSetClass.setState(23702,1);
            return;
         }
      }
      
      public function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([104641],function(param1:Array):void
         {
            var arr:Array = param1;
            m_value = arr[0] & 0x0F;
            if(m_value == 1)
            {
               SocketConnection.sendByQueue(43305,[18,2],function(param1:*):void
               {
               });
            }
            if(m_value < 3)
            {
               depthLevel["fight"].visible = true;
               depthLevel["tips"].visible = true;
               depthLevel["biaoji"].visible = true;
               conLevel["door_2"].visible = false;
               initPos = new Point(793,107);
               MainManager.actorModel.pos = initPos.clone();
            }
            else
            {
               depthLevel["fight"].visible = false;
               depthLevel["biaoji"].visible = false;
               depthLevel["tips"].visible = false;
               conLevel["door_2"].visible = true;
               initPos = new Point(100,384);
               MainManager.actorModel.pos = initPos.clone();
            }
         });
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target.name)
         {
            case "fight":
               NpcDialog.show(2151,["你们……留下！"],["准备作战！","用钻石砸晕它！","躲闪开来。"],[function():void
               {
                  FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
                  {
                     FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
                  });
                  FightManager.fightNoMapBoss("",14760);
                  update();
               },function():void
               {
                  KTool.buyProductByCallback(254932,1,function():void
                  {
                     SocketConnection.sendByQueue(43305,[18,3],function(param1:*):void
                     {
                        update();
                     });
                  });
               },null],false,null,true);
         }
      }
      
      public function onConClick1(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "door_1":
               MapManager.changeMap(11762);
               break;
            case "door_2":
               MapManager.changeMap(11764);
         }
      }
      
      private function playAnimation() : void
      {
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("MinaVillageUndercurrentS2"),this.stopPlaying);
      }
      
      private function stopPlaying() : void
      {
         NpcDialogNew_1.show(3031,["糟了！加尔鲁什怎么会出现在这里！"],null,null,false,function():void
         {
            NpcDialogNew_1.show(3032,["它被混沌气息魔化了！我们必须解决掉它！"],["我们上！"],[function():void
            {
            }]);
         });
      }
      
      public function onWalkEnter(param1:RobotEvent) : void
      {
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         depthLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick1);
         ToolBarController.panel.visible = true;
      }
   }
}

