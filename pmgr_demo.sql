-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 31, 2013 at 10:51 AM
-- Server version: 5.6.12-log
-- PHP Version: 5.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(100) NOT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=68 ;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`project_id`, `project_name`) VALUES
(67, 'new project number two'),
(66, 'new project again'),
(65, 'new project');

-- --------------------------------------------------------

--
-- Table structure for table `project_bugs`
--

CREATE TABLE IF NOT EXISTS `project_bugs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `entry` text NOT NULL,
  `open` tinyint(1) NOT NULL,
  `date_opened` text NOT NULL,
  `date_closed` text NOT NULL,
  `notes` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

--
-- Dumping data for table `project_bugs`
--

INSERT INTO `project_bugs` (`id`, `project_id`, `entry`, `open`, `date_opened`, `date_closed`, `notes`) VALUES
(55, 65, 'new bug for new project', 0, '7-30-13', '', ''),
(56, 67, 'first bug', 0, '7-30-13', '', 'This bug is closed.'),
(57, 66, 'bug', 0, '7-30-13', '', ''),
(58, 66, 'another one ', 1, '7-30-13', '', 'and this'),
(59, 65, 'This is a bug', 1, '7-30-13', '', 'This is a note'),
(60, 67, 'Yet another bug.', 1, '7-30-13', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `project_logs`
--

CREATE TABLE IF NOT EXISTS `project_logs` (
  `project_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` text NOT NULL,
  `entry_text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=219 ;

--
-- Dumping data for table `project_logs`
--

INSERT INTO `project_logs` (`project_id`, `id`, `date`, `entry_text`) VALUES
(67, 216, '7-30-13', 'first entry'),
(61, 212, '7-30-13', 'asadasdas'),
(62, 213, '7-30-13', 'asdsadad'),
(65, 214, '7-30-13', 'Logs are ordered by date.'),
(66, 215, '7-30-13', 'This is an example of a log entry.  Edit in place and the entry is saved when the text area loses focus.'),
(65, 218, '7-30-13', 'The editor for new entries is context sensitive and will open up the relevant dialog based on the tab that is selected.');

-- --------------------------------------------------------

--
-- Table structure for table `project_specs`
--

CREATE TABLE IF NOT EXISTS `project_specs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `spec` text NOT NULL,
  `open` tinyint(1) NOT NULL,
  `notes` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=93 ;

--
-- Dumping data for table `project_specs`
--

INSERT INTO `project_specs` (`id`, `project_id`, `spec`, `open`, `notes`) VALUES
(89, 65, 'More text for a spec entry', 1, 'more notes'),
(90, 65, 'Clicking on the text will open an edit in place text area.', 1, 'notes,  notes, notes'),
(91, 67, 'spec', 1, ''),
(92, 66, 'spec', 1, '');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
